class SlidesController < ApplicationController
  def index
    # Find the course by course_id
    course = Course.find_by(id: params[:course_id])

    if course
      # Fetch all slides belonging to the course
      slides = course.slides.select(:id, :page_number, :indicator, :template_name, :text_for_display, :prompt, :text_for_voiceover)
      templates = Template.pluck(:name, :slots)
      render json: { slides:, templates:, }, status: :ok
    else
      # Handle case where course_id is invalid or not found
      render json: { error: "Course not found" }, status: :not_found
    end
  end

  def update
    @slide = Slide.find(params[:id])

    if @slide.update(slide_params)
      render json: {
        status: 'success',
        slide: @slide
      }, status: :ok
    else
      render json: {
        status: 'error',
        errors: @slide.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def generate
    # Define the API endpoint and your API key
    api_url = 'https://api.openai.com/v1/chat/completions'
    api_key = ENV['Chat_Completion']

    # Input parameters
    general_prompt = params[:general_prompt]
    input_object = params[:input_object]

    # Ensure required params are present
    if general_prompt.blank? || input_object.blank?
      return render json: { error: 'Missing general_prompt or input_object' }, status: :unprocessable_entity
    end

    # Build the API payload
    payload = {
      model: "gpt-4o-2024-08-06",
      messages: [
        {
          role: "system",
          content: "You are generating 1 slide content for a course. Focus on clarity and ensure slide text and voiceover text complement each other. Don't repeat explicit information in slides. Only explain further when you feel necessary in voiceover."
        },
        {
          role: "user",
          content: "#{general_prompt}"
        },
        {
          role: "user",
          content: "Here is the object input: #{input_object}"
        }
      ],
      response_format: {
        type: "json_schema",
        json_schema: {
          name: "slide_content_schema",
          schema: {
            type: "object",
            properties: {
              body: {
                description: "The body text to display on the slide.",
                type: "string"
              },
              text_for_voiceover: {
                description: "The complementary text for the voiceover.",
                type: "string"
              }
            },
            additionalProperties: false
          }
        }
      }
    }

    # Make the API request
    uri = URI(api_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.path, {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{api_key}"
    })

    request.body = payload.to_json

    begin
      response = http.request(request)

      if response.code.to_i == 200
        response_body = JSON.parse(response.body)
        content = response_body.dig('choices', 0, 'message', 'content')

        # Parse the content string into JSON
        parsed_content = JSON.parse(content)

        render json: {
          body: parsed_content['body'],
          text_for_voiceover: parsed_content['text_for_voiceover']
        }
      else
        render json: { error: "API call failed", details: response.body }, status: :unprocessable_entity
      end
    rescue => e
      render json: { error: "Request error", message: e.message }, status: :internal_server_error
    end
  end

  private

  # Strong parameters to permit the fields
  def slide_params
    params.require(:slide).permit(:text_for_display, :text_for_voiceover, :prompt)
  end
end
