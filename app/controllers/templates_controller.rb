class TemplatesController < ApplicationController
  before_action :set_template, only: %i[destroy edit update]

  def index
    @templates = Template.select(:id, :name, :slots, :description)

    render json: @templates.to_json, status: :ok
  end

  def new

  end

  def create
    # logger.debug "Parameters: #{params.inspect}"

    @template = Template.new(template_params)

    if @template.save
      render json: {
        id: @template.id,
        slots: @template.slots,
        description: @template.description,
        name: @template.name,
        message: "Template created successfully!"
      }, status: :created
    else
      render json: {
        error: "Failed to create new template"
      }, status: :unprocessable_content
    end
  end

  def edit

  end

  def destroy
    @template.destroy!
    render json: {
      message: "Template deleted!"
    }, status: :no_content
  end

  def update
    if @template.update(template_params)
      render json: {
        message: "Template updated successfully!"
      }, status: :ok
    else
      render json: {
        error: "Failed to update template!"
      }, status: :unprocessable_content
    end
  end

  private

  def template_params
    params.require(:template).permit(:slots, :description, :name)
  end

  def set_template
    @template = Template.find(params.expect(:id))
  end

end
