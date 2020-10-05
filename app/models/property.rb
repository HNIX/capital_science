# == Schema Information
#
# Table name: properties
#
#  id             :bigint           not null, primary key
#  address        :string
#  address1       :string
#  address2       :string
#  address_city   :string
#  address_object :jsonb
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
  #geocoded_by :full_address
  #after_validation :geocode, if: :address_field_changed? 

  validates :address, presence: :true

  # def address
  # 	[address1, address_city, address_zip, address_state].compact.join(", ")
  # end
  def full_address
    address
  end

  def address_field_changed? 
    address_changed? 
  end

  scope :sorted, ->{ order(created_at: :asc)}
end
