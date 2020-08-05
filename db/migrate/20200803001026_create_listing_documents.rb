class CreateListingDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :listing_documents do |t|
      t.jsonb :document_data
      t.references :listing, null: false, foreign_key: true

      t.timestamps
    end
  end
end
