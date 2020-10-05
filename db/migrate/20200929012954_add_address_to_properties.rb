class AddAddressToProperties < ActiveRecord::Migration[6.0]
  def change
    add_column :properties, :address, :string
  end
end
