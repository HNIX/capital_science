class CreatePropertyListings < ActiveRecord::Migration[6.0]
  def change
    create_table :property_listings do |t|
      t.references :listing, null: false, foreign_key: true
      t.references :property, null: false, foreign_key: true

      t.timestamps
    end
  end
end
