class CreateLists < ActiveRecord::Migration[6.0]
  def change
    create_table :lists do |t|
      t.references :owner
      t.string :name
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
