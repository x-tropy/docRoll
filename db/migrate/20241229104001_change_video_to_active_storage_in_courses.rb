class ChangeVideoToActiveStorageInCourses < ActiveRecord::Migration[8.0]
  def change
    remove_column :courses, :video, :string
  end
end
