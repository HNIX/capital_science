class CreateProperties < ActiveRecord::Migration[6.0]
  def change
    create_table :properties do |t|
      t.references :listing, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :address1
      t.string :address2
      t.string :address_city
      t.string :address_state
      t.string :address_zip

      t.timestamps
    end
  end
end
