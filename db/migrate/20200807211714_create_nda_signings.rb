class CreateNdaSignings < ActiveRecord::Migration[6.0]
  def change
    create_table :nda_signings do |t|
      t.references :account, null: false, foreign_key: true
      t.references :listing, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :signed_on
      t.text :content
      t.string :signature
      t.string :ip_address

      t.timestamps
    end
  end
end
