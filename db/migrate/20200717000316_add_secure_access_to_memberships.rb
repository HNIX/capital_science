class AddSecureAccessToMemberships < ActiveRecord::Migration[6.0]
  def change
  	add_column :memberships, :secure_access, :boolean
  end
end
