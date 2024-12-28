class CreateSlides < ActiveRecord::Migration[8.0]
  def change
    create_table :slides do |t|
      t.text :text_for_display
      t.text :text_for_voiceover
      t.string :image
      t.string :indicator
      t.integer :page_number
      t.references :section, null: false, foreign_key: true

      t.timestamps
    end
  end
end
