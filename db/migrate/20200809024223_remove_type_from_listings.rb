class RemoveTypeFromListings < ActiveRecord::Migration[6.0]
  def change
  	safety_assured { remove_column :listings, :type }
  end
end
