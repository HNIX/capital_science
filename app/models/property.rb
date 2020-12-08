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
#  apn            :string
#  asset_class    :string
#  buildings      :integer
#  floors         :integer
#  frontage       :integer
#  highlights     :text
#  land_area      :float
#  latitude       :float
#  longitude      :float
#  name           :string
#  occupancy      :integer
#  parking_spaces :integer
#  primary_type   :string
#  rent_type      :string
#  rsf            :integer
#  secondary_type :string
#  sf             :integer
#  units          :integer
#  year_built     :integer
#  zoning         :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  account_id     :bigint
#
# Indexes
#
#  index_properties_on_account_id  (account_id)
#
class Property < ApplicationRecord
  belongs_to :account
  has_rich_text :highlights
  has_one_attached :cover_image
  has_many :property_images, dependent: :destroy
  #geocoded_by :full_address
  #after_validation :geocode, if: :address_field_changed? 
  has_many :property_listings
  has_many :listings, through: :property_listings

  has_many :property_contacts
  has_many :contacts, through: :property_contacts

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

  accepts_nested_attributes_for :property_images, allow_destroy: true
end
