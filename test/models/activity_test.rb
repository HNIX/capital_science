# == Schema Information
#
# Table name: activities
#
#  id         :bigint           not null, primary key
#  comment    :text
#  due_date   :datetime
#  event      :string
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :bigint           not null
#  owner_id   :bigint
#
# Indexes
#
#  index_activities_on_account_id  (account_id)
#  index_activities_on_owner_id    (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
require 'test_helper'

class ActivityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
