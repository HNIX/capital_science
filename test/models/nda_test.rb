# == Schema Information
#
# Table name: ndas
#
#  id         :bigint           not null, primary key
#  content    :text
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :bigint           not null
#
# Indexes
#
#  index_ndas_on_account_id  (account_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
require 'test_helper'

class NdaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
