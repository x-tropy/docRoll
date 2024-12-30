class AddNameToTemplates < ActiveRecord::Migration[8.0]
  def change
    add_column :templates, :name, :string
  end
end
