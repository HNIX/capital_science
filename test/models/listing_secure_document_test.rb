# == Schema Information
#
# Table name: listing_secure_documents
#
#  id                   :bigint           not null, primary key
#  secure_document_data :jsonb
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  listing_id           :bigint           not null
#
# Indexes
#
#  index_listing_secure_documents_on_listing_id  (listing_id)
#
# Foreign Keys
#
#  fk_rails_...  (listing_id => listings.id)
#
require 'test_helper'

class ListingSecureDocumentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
