# == Schema Information
#
# Table name: memberships
#
#  id            :bigint           not null, primary key
#  roles         :jsonb
#  secure_access :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  listing_id    :bigint           not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_memberships_on_listing_id  (listing_id)
#  index_memberships_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (listing_id => listings.id)
#  fk_rails_...  (user_id => users.id)
#
class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :listing
  has_many :contact_memberships
  has_many :contacts, through: :contact_memberships, dependent: :destroy

  validates :user_id, uniqueness: {scope: :listing_id, message: "is already a member of this listing"}
  # validate :owner_must_be_admin, on: :update, if: ->{ admin_changed? && account_owner? }

  # Add account roles to this line
  ROLES = [:guest, :investor, :broker]

  # Store the roles in the roles json column and cast to booleans
  store_accessor :roles, *ROLES

  # Cast roles to/from booleans
  ROLES.each do |role|
    scope role, -> { where("roles @> ?", {role => true}.to_json) }

    define_method(:"#{role}=") { |value| super ActiveRecord::Type::Boolean.new.cast(value) }
    define_method(:"#{role}?") { send(role) }
  end

  def active_roles
    ROLES.select { |role| send(:"#{role}?") }.compact
  end

  # def account_owner?
  #   account.owner_id == user_id
  # end

  # def owner_must_be_admin
  #   unless admin?
  #     errors.add(:admin, 'role cannot be removed for the account owner')
  #   end
  # end
end
