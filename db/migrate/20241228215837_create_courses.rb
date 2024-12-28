class CreateCourses < ActiveRecord::Migration[8.0]
  def change
    create_table :courses do |t|
      t.string :title
      t.date :production_date
      t.string :author
      t.string :link
      t.text :raw
      t.string :video
      t.text :toc

      t.timestamps
    end
  end
end
