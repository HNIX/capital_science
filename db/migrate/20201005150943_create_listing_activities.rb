class CreateListingActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :listing_activities do |t|
      t.references :listing, null: false, foreign_key: true
      t.references :activity, null: false, foreign_key: true

      t.timestamps
    end
  end
end
