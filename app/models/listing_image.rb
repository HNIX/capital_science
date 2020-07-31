# == Schema Information
#
# Table name: listing_images
#
#  id         :bigint           not null, primary key
#  image_data :jsonb
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  listing_id :bigint           not null
#
# Indexes
#
#  index_listing_images_on_listing_id  (listing_id)
#
class ListingImage < ApplicationRecord
  include ImageUploader::Attachment(:image)
  belongs_to :listing
  
  validates_presence_of :image
end
