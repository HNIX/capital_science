# == Schema Information
#
# Table name: listing_activities
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  activity_id :bigint           not null
#  listing_id  :bigint           not null
#
# Indexes
#
#  index_listing_activities_on_activity_id  (activity_id)
#  index_listing_activities_on_listing_id   (listing_id)
#
# Foreign Keys
#
#  fk_rails_...  (activity_id => activities.id)
#  fk_rails_...  (listing_id => listings.id)
#
class ListingActivity < ApplicationRecord
  belongs_to :listing
  belongs_to :activity
end
