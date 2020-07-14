# == Schema Information
#
# Table name: properties
#
#  id            :bigint           not null, primary key
#  address1      :string
#  address2      :string
#  address_city  :string
#  address_state :string
#  address_zip   :string
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  listing_id    :bigint           not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_properties_on_listing_id  (listing_id)
#  index_properties_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (listing_id => listings.id)
#  fk_rails_...  (user_id => users.id)
#
class Property < ApplicationRecord
  belongs_to :listing
  belongs_to :user

  scope :sorted, ->{ order(created_at: :asc)}
end
