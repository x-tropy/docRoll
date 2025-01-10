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

      # slide creator job done successfully
      if SlideCreatorJob.perform_now(course_id)
        render json: { status: "success", sections: sections }, status: :created
      else
        raise ActiveRecord::Rollback, "\n\n\n>>Slide creation failed<<\n\n\n"
      end
    end

  rescue ActiveRecord::RecordInvalid => e
    render json: { status: "error", errors: e.record.errors.full_messages }, status: :unprocessable_entity
  rescue => e
    render json: { status: "error", errors: ["Slide creation failed: #{e.message}"] }, status: :unprocessable_entity
  end

  private

  def section_params
    params.permit(:course_id, :sections)
  end
end
