class AddSubtitlesToVoiceovers < ActiveRecord::Migration[8.0]
  def change
    add_column :voiceovers, :subtitles, :text
  end
end
