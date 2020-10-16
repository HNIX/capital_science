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

  has_many :contact_listing_invitations
  has_many :listing_invitations, through: :contact_listing_invitations, dependent: :destroy

  has_many :contact_memberships
  has_many :memberships, through: :contact_memberships, dependent: :destroy

  has_many :contact_activities
  has_many :activities, through: :contact_activities

  has_person_name

  # Store the roles in the roles json column and cast to booleans
  store_accessor :role, *Membership::ROLES

  # Cast roles to/from booleans
  Membership::ROLES.each do |role|
    define_method(:"#{role}=") { |value| super ActiveRecord::Type::Boolean.new.cast(value) }
    define_method(:"#{role}?") { send(role) }
  end

  


end
