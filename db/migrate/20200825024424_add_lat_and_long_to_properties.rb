class AddLatAndLongToProperties < ActiveRecord::Migration[6.0]
  def change
    add_column :properties, :latitude, :float
    add_column :properties, :longitude, :float
  end
end
