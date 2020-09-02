# == Schema Information
#
# Table name: contacts
#
#  id         :bigint           not null, primary key
#  company    :string
#  email      :string
#  first_name :string
#  last_name  :string
#  phone      :string
#  role       :jsonb
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :bigint           not null
#  owner_id   :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_contacts_on_account_id  (account_id)
#  index_contacts_on_owner_id    (owner_id)
#  index_contacts_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class Contact < ApplicationRecord
  belongs_to :account
  #belongs_to :user
  belongs_to :owner, :class_name => 'User'
  has_many :contact_lists
  has_many :lists, through: :contact_lists
end
