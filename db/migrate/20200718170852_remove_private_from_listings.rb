class RemovePrivateFromListings < ActiveRecord::Migration[6.0]
  def change
  	safety_assured { remove_column :listings, :private }
  end
end
