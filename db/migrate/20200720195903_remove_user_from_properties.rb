class RemoveUserFromProperties < ActiveRecord::Migration[6.0]
  def change
  	safety_assured { remove_reference :properties, :user }
  end
end
