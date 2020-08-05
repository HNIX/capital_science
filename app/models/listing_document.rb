# == Schema Information
#
# Table name: listing_documents
#
#  id            :bigint           not null, primary key
#  document_data :jsonb
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  listing_id    :bigint           not null
#
# Indexes
#
#  index_listing_documents_on_listing_id  (listing_id)
#
# Foreign Keys
#
#  fk_rails_...  (listing_id => listings.id)
#
class ListingDocument < ApplicationRecord
  include DocumentUploader::Attachment(:document)
  belongs_to :listing
  
  validates_presence_of :document
end
