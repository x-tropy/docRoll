class SectionsController < ApplicationController
  def create
    course_id = section_params[:course_id]

    # Remove all existing sections
    # and their associated slides for the course_id
    Section.where(course_id: course_id).delete_all
    sections_data = JSON.parse(section_params[:sections]).map do |section_data|
      {
        course_id: course_id,
        raw: section_data["raw"], # Ensure keys are strings since JSON.parse outputs string keys
        role: section_data["role"]
      }
    end

    sections = sections_data.map { |data| Section.new(data) }

    Section.transaction do
      sections.each(&:save!)

      # Trigger slide creation after sections are saved
      SlideCreatorJob.perform_later(course_id)
    end

    render json: { status: "success", sections: sections }, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { status: "error", errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  private

  def section_params
    params.permit(:course_id, :sections)
  end
end
