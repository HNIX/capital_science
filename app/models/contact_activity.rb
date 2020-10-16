# == Schema Information
#
# Table name: contact_activities
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  activity_id :bigint           not null
#  contact_id  :bigint           not null
#
# Indexes
#
#  index_contact_activities_on_activity_id  (activity_id)
#  index_contact_activities_on_contact_id   (contact_id)
#
# Foreign Keys
#
#  fk_rails_...  (activity_id => activities.id)
#  fk_rails_...  (contact_id => contacts.id)
#
class ContactActivity < ApplicationRecord
  belongs_to :contact
  belongs_to :activity
end
