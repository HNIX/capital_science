# == Schema Information
#
# Table name: account_invitations
#
#  id            :bigint           not null, primary key
#  email         :string
#  name          :string
#  roles         :jsonb            not null
#  token         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  account_id    :bigint           not null
#  invited_by_id :bigint
#
# Indexes
#
#  index_account_invitations_on_account_id     (account_id)
#  index_account_invitations_on_invited_by_id  (invited_by_id)
#  index_account_invitations_on_token          (token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (invited_by_id => users.id)
#
require "test_helper"

class AccountInvitationTest < ActiveSupport::TestCase
  setup do
    @account_invitation = account_invitations(:one)
  end

  test "accept" do
    user = users(:invited)
    assert_difference "AccountUser.count" do
      account_user = @account_invitation.accept!(user)
      assert account_user.persisted?
      assert_equal user, account_user.user
    end

    assert_raises ActiveRecord::RecordNotFound do
      @account_invitation.reload
    end
  end

  test "reject" do
    assert_difference "AccountInvitation.count", -1 do
      @account_invitation.reject!
    end
  end
end
