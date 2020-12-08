class AddHighlightsToProperties < ActiveRecord::Migration[6.0]
  def change
    add_column :properties, :highlights, :text
  end
end
