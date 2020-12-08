class RemoveListingsFromProperties < ActiveRecord::Migration[6.0]
  def change
    safety_assured { remove_column :properties, :listing_id }
  end
end
