# == Schema Information
#
# Table name: property_images
#
#  id          :bigint           not null, primary key
#  image_data  :jsonb
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  property_id :bigint           not null
#
# Indexes
#
#  index_property_images_on_property_id  (property_id)
#
# Foreign Keys
#
#  fk_rails_...  (property_id => properties.id)
#
class PropertyImage < ApplicationRecord
  include ImageUploader::Attachment(:image)
  belongs_to :property
  
  validates_presence_of :image
end
