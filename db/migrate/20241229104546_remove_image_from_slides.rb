class RemoveImageFromSlides < ActiveRecord::Migration[8.0]
  def change
    remove_column :slides, :image
  end
end
