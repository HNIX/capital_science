class CreateListingSecureDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :listing_secure_documents do |t|
      t.jsonb :secure_document_data
      t.references :listing, null: false, foreign_key: true

      t.timestamps
    end
  end
end
