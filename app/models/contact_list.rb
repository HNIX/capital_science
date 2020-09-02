class ContactList < ApplicationRecord
  belongs_to :list
  belongs_to :contact
end
