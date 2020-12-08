class AddInfoToProperties < ActiveRecord::Migration[6.0]
  def change
    add_column :properties, :year_built, :integer
    add_column :properties, :rsf, :integer
    add_column :properties, :occupancy, :integer
    add_column :properties, :parking_spaces, :integer
    add_column :properties, :frontage, :integer
    add_column :properties, :apn, :string
  end
end
