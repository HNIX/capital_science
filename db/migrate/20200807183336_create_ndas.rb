class CreateNdas < ActiveRecord::Migration[6.0]
  def change
    create_table :ndas do |t|
      t.string :name
      t.text :content
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
