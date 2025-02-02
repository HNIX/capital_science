# == Schema Information
#
# Table name: listings
#
#  id              :bigint           not null, primary key
#  aasm_state      :string
#  active_at       :datetime
#  cap_rate        :float
#  closed_at       :datetime
#  description     :text
#  hide_price      :boolean
#  inactive_at     :datetime
#  investment_type :string
#  noi             :float
#  price           :float
#  private_listing :boolean          default(FALSE)
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  account_id      :bigint           not null
#  nda_id          :bigint
#  owner_id        :bigint
#
# Indexes
#
#  index_listings_on_account_id  (account_id)
#  index_listings_on_nda_id      (nda_id)
#  index_listings_on_owner_id    (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => users.id)
#
require 'test_helper'

class ListingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
