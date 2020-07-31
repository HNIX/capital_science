class ValidateOwnerOnListings < ActiveRecord::Migration[6.0]
  def change
  	 validate_foreign_key :listings, :users
  end
end
