class TemplatesController < ApplicationController
  def index
    @templates = Template.all
  end

  def create
    # logger.debug "Parameters: #{params.inspect}"

    @template = Template.new(template_params)


    if @template.save
      render json: {
        id: @template.id,
        slots: @template.slots,
        description: @template.description
      }, status: :created
    else
      render json: {
        error: "Failed to create new template"
      }, status: :unprocessable_content
    end
  end

  private

  def template_params
    params.require(:template).permit(:slots, :description)
  end

end
