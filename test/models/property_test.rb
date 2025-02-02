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
require 'test_helper'

class PropertyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
