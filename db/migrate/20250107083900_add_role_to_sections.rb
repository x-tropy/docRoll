class AddRoleToSections < ActiveRecord::Migration[8.0]
  def change
    add_column :sections, :role, :string
  end
end
