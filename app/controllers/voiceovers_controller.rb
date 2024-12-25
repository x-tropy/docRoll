class VoiceoversController < ApplicationController
  def new
    @voiceover = Voiceover.new
  end

  def create
    @voiceover = Voiceover.new(voiceover_params)

    if @voiceover.save
      # Trigger audio generation after saving the text
      generate_audio(@voiceover)
      redirect_to @voiceover, notice: "Voiceover created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @voiceover = Voiceover.find(params[:id])
  end

  private

  def voiceover_params
    params.require(:voiceover).permit(:text)
  end

  def generate_audio(voiceover)
    # Replace this with actual OpenAI API call logic
    openai_api_key = ENV["Speech_to_Text"]
    uri = URI.parse("https://api.openai.com/v1/audio/speech")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request["Authorization"] = "Bearer #{openai_api_key}"
    request.body = JSON.dump({ "input" => voiceover.text, "voice" => "alloy", "model" => "tts-1" })

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    if response.is_a?(Net::HTTPSuccess)
      audio_data = response.body
      voiceover.file.attach(
        io: StringIO.new(audio_data),
        filename: "voiceover_#{voiceover.id}.mp3",
        content_type: "audio/mpeg"
      )
    else
      flash[:alert] = "Audio generation failed: #{response.body}"
    end
  end
end
