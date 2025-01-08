class UpdateSlidesRemoveTemplateIdAddTemplateName < ActiveRecord::Migration[8.0]
  def change
    # Remove the foreign key and column
    remove_column :slides, :template_id, :integer

    # Add the new template_name field
    add_column :slides, :template_name, :string
  end
end
