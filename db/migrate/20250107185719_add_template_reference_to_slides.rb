class AddTemplateReferenceToSlides < ActiveRecord::Migration[8.0]
  def change
    add_reference :slides, :template, null: true, foreign_key: true
  end
end
