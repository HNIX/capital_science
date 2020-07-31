class RemoveUserFromImages < ActiveRecord::Migration[6.0]
  def change
  	safety_assured { remove_reference :listing_images, :user }
  end
end
