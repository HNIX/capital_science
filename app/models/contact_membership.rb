# == Schema Information
#
# Table name: contact_memberships
#
#  id            :bigint           not null, primary key
#  contact_id    :bigint           not null
#  membership_id :bigint           not null
#
# Indexes
#
#  index_contact_memberships_on_contact_id     (contact_id)
#  index_contact_memberships_on_membership_id  (membership_id)
#
# Foreign Keys
#
#  fk_rails_...  (contact_id => contacts.id)
#  fk_rails_...  (membership_id => memberships.id)
#
class ContactMembership < ApplicationRecord
  belongs_to :membership
  belongs_to :contact
end
