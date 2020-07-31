class AddDetailsToProperties < ActiveRecord::Migration[6.0]
  def change
  	add_column :properties, :primary_type, :string
  	add_column :properties, :secondary_type, :string
  	add_column :properties, :asset_class, :string
  	add_column :properties, :rent_type, :string
  	add_column :properties, :units, :integer
  	add_column :properties, :sf, :integer
  	add_column :properties, :floors, :integer
  	add_column :properties, :buildings, :integer
  	add_column :properties, :land_area, :float
  	add_column :properties, :zoning, :string
  end
end
