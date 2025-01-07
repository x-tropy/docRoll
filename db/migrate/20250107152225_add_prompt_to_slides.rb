class AddPromptToSlides < ActiveRecord::Migration[8.0]
  def change
    add_column :slides, :prompt, :text
  end
end
