class ContactMembership < ApplicationRecord
  belongs_to :membership
  belongs_to :contact
end
