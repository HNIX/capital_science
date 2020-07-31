class AddDetailsToListings < ActiveRecord::Migration[6.0]
  def change
  	add_column :listings, :price, :float
  	add_column :listings, :hide_price, :boolean
  	add_column :listings, :cap_rate, :float
  	add_column :listings, :type, :string
  	add_column :listings, :noi, :float
  end
end
