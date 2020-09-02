# == Schema Information
#
# Table name: lists
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :bigint           not null
#  owner_id   :bigint
#
# Indexes
#
#  index_lists_on_account_id  (account_id)
#  index_lists_on_owner_id    (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
require 'test_helper'

class ListTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
