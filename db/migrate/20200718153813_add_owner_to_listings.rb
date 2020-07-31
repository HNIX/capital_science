class AddOwnerToListings < ActiveRecord::Migration[6.0]
  def change
	safety_assured { remove_reference :listings, :user, index:true, foreign_key: true }
  	
  
  end
end
