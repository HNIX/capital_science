# == Schema Information
#
# Table name: nda_signings
#
#  id         :bigint           not null, primary key
#  content    :text
#  ip_address :string
#  signature  :string
#  signed_on  :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :bigint           not null
#  listing_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_nda_signings_on_account_id  (account_id)
#  index_nda_signings_on_listing_id  (listing_id)
#  index_nda_signings_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (listing_id => listings.id)
#  fk_rails_...  (user_id => users.id)
#
class NdaSigning < ApplicationRecord
  belongs_to :account
  belongs_to :listing
  belongs_to :user

  has_rich_text :content

  validates :content, presence: :true
  validates :signature, presence: :true
end
