class CreatePropertyContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :property_contacts do |t|
      t.references :property, null: false, foreign_key: true
      t.references :contact, null: false, foreign_key: true

      t.timestamps
    end
  end
end
