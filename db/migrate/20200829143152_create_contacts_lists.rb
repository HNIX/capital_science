class CreateContactsLists < ActiveRecord::Migration[6.0]
  def change
    create_table :contact_lists do |t|
      t.references :contact
      t.references :list
    end
  end
end