# == Schema Information
#
# Table name: contact_lists
#
#  id         :bigint           not null, primary key
#  contact_id :bigint
#  list_id    :bigint
#
# Indexes
#
#  index_contact_lists_on_contact_id  (contact_id)
#  index_contact_lists_on_list_id     (list_id)
#
class ContactList < ApplicationRecord
  belongs_to :list
  belongs_to :contact
end
