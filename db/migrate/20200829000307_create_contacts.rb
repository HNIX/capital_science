class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.string :email
      t.string :phone
      t.string :first_name
      t.string :last_name
      t.references :account, null: false, foreign_key: true
      t.references :user
      t.references :owner
      t.string :company
      t.jsonb :role

      t.timestamps
    end
  end
end
