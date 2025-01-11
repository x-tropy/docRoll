class SlidesController < ApplicationController
  def index
    # Find the course by course_id
    course = Course.find_by(id: params[:course_id])

    if course
      # Fetch all slides belonging to the course
      slides = course.slides.select(:page_number, :indicator, :template_name, :text_for_display, :prompt, :text_for_voiceover)
      templates = Template.pluck(:name, :slots)
      render json: { slides:, templates:, }, status: :ok
    else
      # Handle case where course_id is invalid or not found
      render json: { error: "Course not found" }, status: :not_found
    end
  end
end
