# == Schema Information
#
# Table name: listing_invitations
#
#  id         :bigint           not null, primary key
#  email      :string
#  name       :string
#  roles      :jsonb
#  token      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  listing_id :bigint           not null
#  sender_id  :bigint           not null
#
# Indexes
#
#  index_listing_invitations_on_listing_id  (listing_id)
#  index_listing_invitations_on_sender_id   (sender_id)
#
# Foreign Keys
#
#  fk_rails_...  (listing_id => listings.id)
#  fk_rails_...  (sender_id => users.id)
#
require 'test_helper'

class ListingInvitationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
