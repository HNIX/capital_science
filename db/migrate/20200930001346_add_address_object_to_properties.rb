class AddAddressObjectToProperties < ActiveRecord::Migration[6.0]
  def change
    add_column :properties, :address_object, :jsonb
  end
end
