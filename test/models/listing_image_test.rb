# == Schema Information
#
# Table name: listing_images
#
#  id         :bigint           not null, primary key
#  image_data :jsonb
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  listing_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_listing_images_on_listing_id  (listing_id)
#  index_listing_images_on_user_id     (user_id)
#
require 'test_helper'

class ListingImageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
