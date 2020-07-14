# == Schema Information
#
# Table name: listings
#
#  id              :bigint           not null, primary key
#  aasm_state      :string
#  description     :text
#  private         :boolean          not null
#  private_listing :boolean          default(FALSE)
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  account_id      :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_listings_on_account_id  (account_id)
#  index_listings_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'test_helper'

class ListingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
