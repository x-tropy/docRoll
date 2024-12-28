class AddSlideToVoiceovers < ActiveRecord::Migration[8.0]
  def change
    add_reference :voiceovers, :slide, null: true, foreign_key: true
  end
end
