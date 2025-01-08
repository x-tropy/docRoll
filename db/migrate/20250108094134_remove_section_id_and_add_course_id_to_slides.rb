class RemoveSectionIdAndAddCourseIdToSlides < ActiveRecord::Migration[8.0]
  def change
    remove_reference :slides, :section, foreign_key: true
    add_reference :slides, :course, foreign_key: true
  end
end
