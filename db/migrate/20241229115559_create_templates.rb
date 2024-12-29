class CreateTemplates < ActiveRecord::Migration[8.0]
  def change
    create_table :templates do |t|
      t.text :slots
      t.string :description

      t.timestamps
    end
  end
end
