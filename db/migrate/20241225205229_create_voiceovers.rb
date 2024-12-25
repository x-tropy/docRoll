class CreateVoiceovers < ActiveRecord::Migration[8.0]
  def change
    create_table :voiceovers do |t|
      t.text :text

      t.timestamps
    end
  end
end
