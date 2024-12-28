class CreateSections < ActiveRecord::Migration[8.0]
  def change
    create_table :sections do |t|
      t.text :raw
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
