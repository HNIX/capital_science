# == Schema Information
#
# Table name: property_contacts
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  contact_id  :bigint           not null
#  property_id :bigint           not null
#
# Indexes
#
#  index_property_contacts_on_contact_id   (contact_id)
#  index_property_contacts_on_property_id  (property_id)
#
# Foreign Keys
#
#  fk_rails_...  (contact_id => contacts.id)
#  fk_rails_...  (property_id => properties.id)
#
class PropertyContact < ApplicationRecord
  belongs_to :property
  belongs_to :contact
end
