class VoiceoversController < ApplicationController
  def new
    @voiceover = Voiceover.new
  end

  def create
    @voiceover = Voiceover.new(voiceover_params)

    if @voiceover.save
      # Trigger audio generation after saving the text
      generate_audio(@voiceover)

      respond_to do |format|
        format.html do
          redirect_to @voiceover, notice: "Voiceover created successfully!"
        end
        format.json do
          render json: {
            message: "Voiceover created successfully!",
            audio_url: url_for(@voiceover.file),
            subtitles: @voiceover.subtitles.present? ? JSON.parse(@voiceover.subtitles) : nil
          }, status: :created
        end
      end
    else
      respond_to do |format|
        format.html do
          render :new, status: :unprocessable_entity
        end
        format.json do
          render json: {
            errors: @voiceover.errors.full_messages
          }, status: :unprocessable_entity
        end
      end
    end
  end

  def show
    @voiceover = Voiceover.find(params[:id])
  end

  private

  def voiceover_params
    params.require(:voiceover).permit(:text, :slide_id)
  end

  def generate_audio(voiceover)
    api_key = ENV["Text_to_Speech"]
    voice_id = "21m00Tcm4TlvDq8ikWAM" # Rachel's voice
    uri = URI.parse("https://api.elevenlabs.io/v1/text-to-speech/#{voice_id}/with-timestamps?output_format=mp3_22050_32")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request["Xi-Api-Key"] = api_key
    request.body = JSON.dump(
      {
        "text" => voiceover.text,
        "model_id" => "eleven_turbo_v2",
        "voice_settings" => {
          "stability" => 0.5,
          "similarity_boost" => 0.75
        }
      }
    )

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    if response.is_a?(Net::HTTPSuccess)
      # careful, now data is in Ruby Hash
      data = JSON.parse(response.body)

      decoded_audio = Base64.decode64(
        data["audio_base64"]
      )

      voiceover.file.attach(
        io: StringIO.new(decoded_audio),
        filename: "voiceover_#{voiceover.id}.mp3",
        content_type: "audio/mpeg"
      )

      voiceover.update(
        transcription: data["normalized_alignment"].to_json,
        subtitles: get_subtitles(data["normalized_alignment"]).to_json
      )
    else
      logger.error "\n\n\n>> Audio generation failed: #{response.body}<<\n\n\n"
      flash[:alert] = "Audio generation failed: #{response.body}"
    end
  end

  def get_subtitles(alignment)
    characters = alignment["characters"]
    start_times = alignment["character_start_times_seconds"]
    end_times = alignment["character_end_times_seconds"]

    # Group characters into words
    words = group_characters_to_words(characters, start_times, end_times)

    # Split into subtitles
    subtitles = split_into_subtitles(words, max_words: 15, min_words: 5)
    subtitles

    # Output subtitles
    # subtitles.each_with_index do |subtitle, index|
    #   puts "\n👉 Subtitle #{index + 1}:"
    #   puts "   Text: #{subtitle[:text]}"
    #   puts "   Start Time: #{'%.3f' % subtitle[:start_time]}s"
    #   puts "   End Time: #{'%.3f' % subtitle[:end_time]}s"
    #   puts "   Duration: #{'%.3f' % subtitle[:duration]}s"
    # end
  end

  def group_characters_to_words(characters, start_times, end_times)
    words = []
    current_word = ""
    current_start_time = nil

    characters.each_with_index do |char, index|
      if char == " " || index == characters.size - 1
        # Add current word if it's not empty
        unless current_word.empty?
          end_time = (index == characters.size - 1 && char != " ") ? end_times[index] : end_times[index - 1]
          current_word += char if char != " "
          words << { word: current_word, start_time: current_start_time, end_time: end_time }
          current_word = ""
        end
        current_start_time = nil
      else
        current_word += char
        current_start_time ||= start_times[index]
      end
    end

    words
  end

  def split_into_subtitles(words, max_words:, min_words:)
    subtitles = []
    current_part = []

    words.each do |word|
      current_part << word

      if word[:word].end_with?(".") || current_part.size >= max_words
        # Split at period or when max_words reached
        subtitles << finalize_subtitle(current_part)
        current_part = []
      elsif current_part.size >= min_words && (word[:word].end_with?(",") || word[:word].end_with?(";"))
        # Allow splitting at commas or semicolons if min_words is satisfied
        subtitles << finalize_subtitle(current_part)
        current_part = []
      end
    end

    # Add remaining words
    subtitles << finalize_subtitle(current_part) unless current_part.empty?

    subtitles
  end

  def finalize_subtitle(words)
    {
      text: words.map { |w| w[:word] }.join(" "),
      start_time: words.first[:start_time],
      end_time: words.last[:end_time],
      duration: words.last[:end_time] - words.first[:start_time]
    }
  end

end
