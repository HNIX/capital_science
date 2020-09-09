# == Schema Information
#
# Table name: properties
#
#  id             :bigint           not null, primary key
#  address1       :string
#  address2       :string
#  address_city   :string
#  address_state  :string
#  address_zip    :string
#  asset_class    :string
#  buildings      :integer
#  floors         :integer
#  land_area      :float
#  latitude       :float
#  longitude      :float
#  name           :string
#  primary_type   :string
#  rent_type      :string
#  secondary_type :string
#  sf             :integer
#  units          :integer
#  zoning         :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  listing_id     :bigint           not null
#
# Indexes
#
#  index_properties_on_listing_id  (listing_id)
#
# Foreign Keys
#
#  fk_rails_...  (listing_id => listings.id)
#
class Property < ApplicationRecord
  belongs_to :listing
  geocoded_by :address
  after_validation :geocode, if: :address_changed? 

  validates :address1, presence: :true
  validates :address_city, presence: :true
  validates :address_state, presence: :true
  validates :address_zip, presence: :true

  def address
  	[address1, address_city, address_zip, address_state].compact.join(", ")
  end

  def address_changed? 
  	address1_changed? || address_city_changed? || address_zip_changed? || address_state_changed? 
  end

  scope :sorted, ->{ order(created_at: :asc)}
end
