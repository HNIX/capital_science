# == Schema Information
#
# Table name: property_listings
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  listing_id  :bigint           not null
#  property_id :bigint           not null
#
# Indexes
#
#  index_property_listings_on_listing_id   (listing_id)
#  index_property_listings_on_property_id  (property_id)
#
# Foreign Keys
#
#  fk_rails_...  (listing_id => listings.id)
#  fk_rails_...  (property_id => properties.id)
#
require 'test_helper'

class PropertyListingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
