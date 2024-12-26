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

  def transcribe
    logger.info "-> -> Starting transcription for Voiceover ##{params[:id]}"

    @voiceover = Voiceover.find(params[:id])

    if @voiceover.file.attached?
      logger.debug "-> -> Audio file is attached, proceeding with transcription."
      transcription_result = generate_transcription(@voiceover.file)

      if transcription_result
        @voiceover.update(transcription: transcription_result)
        redirect_to @voiceover, notice: "Transcription generated successfully!"
      else
        redirect_to @voiceover, alert: "Failed to generate transcription."
      end
    else
      redirect_to @voiceover, alert: "No audio file attached to transcribe."
    end
  end

  private

  def generate_transcription(file)
    openai_api_key = ENV["Speech_to_Text"]
    file_path = ActiveStorage::Blob.service.send(:path_for, file.key)

    if file.content_type != 'audio/mpeg'
      logger.error "-> -> File is not an MP3. Content type: #{file.content_type}"
      return nil
    else
      logger.info "-> -> #{file_path}"
    end

    # Create a temporary file with the correct extension
    temp_file = Tempfile.new(["temp_audio", ".mp3"]).tap do |tempfile|
      tempfile.binmode
      tempfile.write(file.download)  # Download and write the file content
      tempfile.rewind
    end

    uri = URI.parse("https://api.openai.com/v1/audio/transcriptions")
    request = Net::HTTP::Post.new(uri)
    request["Authorization"] = "Bearer #{openai_api_key}"
    form_data = [
      ['file', File.open(temp_file.path)],
      ['timestamp_granularities[]', 'word'],
      ['model', 'whisper-1'],
      ['response_format', 'verbose_json']
    ]
    request.set_form form_data, 'multipart/form-data'

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    if response.is_a?(Net::HTTPSuccess)
      response.body
    else
      Rails.logger.error "Transcription API error: #{response.body}"
      nil
    end
  end

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
