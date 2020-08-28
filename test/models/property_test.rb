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
require 'test_helper'

class PropertyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
