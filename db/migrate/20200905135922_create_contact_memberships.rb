class CreateContactMemberships < ActiveRecord::Migration[6.0]
  def change
  	create_table :contact_memberships do |t|
      t.references :membership, null: false, foreign_key: true
      t.references :contact, null: false, foreign_key: true
    end
  end
end
