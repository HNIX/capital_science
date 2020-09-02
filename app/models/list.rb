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
class List < ApplicationRecord
  belongs_to :account
  belongs_to :owner, :class_name => 'User'
  has_many :contact_lists
  has_many :contacts, through: :contact_lists
end
