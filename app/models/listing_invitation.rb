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
class ListingInvitation < ApplicationRecord
  self.ignored_columns = ["recipient_id"]
  belongs_to :listing
  belongs_to :sender, :class_name => 'User', optional: true

  has_secure_token

  validates :name, :email, presence: true
  validates :email, uniqueness: {scope: :listing_id, message: "has already been invited"}

  # Store the roles in the roles json column and cast to booleans
  store_accessor :roles, *Membership::ROLES

  # Cast roles to/from booleans
  Membership::ROLES.each do |role|
    define_method(:"#{role}=") { |value| super ActiveRecord::Type::Boolean.new.cast(value) }
    define_method(:"#{role}?") { send(role) }
  end

  def save_and_send_invite
    if save
      ListingInvitationsMailer.with(listing_invitation: self).invite.deliver_later
    end
  end

  def accept!(user)
    membership = listing.memberships.new(user: user, roles: roles)
    if membership.valid?
      ApplicationRecord.transaction do
        membership.save!
        destroy!
      end
      membership
    else
      errors.add(:base, membership.errors.full_messages.first)
      nil
    end
  end

  def reject!
    destroy
  end

  def to_param
    token
  end

  def generate_token
     self.token = Digest::SHA1.hexdigest([self.listing_id, Time.now, rand].join)
  end
end  
