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
class Activity < ApplicationRecord
  belongs_to :account
  belongs_to :owner, :class_name => 'User'
  has_many :contact_activities
  has_many :contacts, through: :contact_activities
  
  has_many :listing_activities
  has_many :listings, through: :listing_activities

  has_many :user_activities
  has_many :users, through: :user_activities

  EVENTS = [:email, :call, :appointment]
end
