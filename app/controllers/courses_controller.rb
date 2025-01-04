class CoursesController < ApplicationController
  before_action :set_course, only: %i[destroy edit update show]

  def index
    @courses = Course.select(:id, :title, :link, :production_date)

    render json: @courses.to_json, status: :ok
  end

  def show
    render json: @course.to_json, status: :ok
  end

  def new

  end

  def create
    logger.debug "Parameters: #{params.inspect}"

    @course = Course.new(course_params)

    # Check if link is present
    unless params[:link].present?
      return render json: {
        error: "Link field is required"
      }, status: :unprocessable_entity
    end

    if @course.save
      render json: {
        message: "Course created successfully!",
        id: @course.id
      }, status: :created
    else
      render json: {
        error: "Failed to create new course"
      }, status: :unprocessable_content
    end
  end

  def edit

  end

  def destroy
    @course.destroy!
    render json: {
      message: "Course deleted!"
    }, status: :no_content
  end

  def update
    if @course.update(course_params)
      render json: {
        message: "Course updated successfully!"
      }, status: :ok
    else
      render json: {
        error: "Failed to update course!"
      }, status: :unprocessable_content
    end
  end

  private

  def course_params
    params.permit(:title, :production_date, :author, :link, :raw, :toc)
  end

  def set_course
    @course = Course.find(params.expect(:id))

    unless @course
      render json: {
        error: "Course not found with id #{params[:id]}"
      }, status: :not_found
      return
    end
  end

end
