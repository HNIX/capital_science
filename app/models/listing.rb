# == Schema Information
#
# Table name: listings
#
#  id              :bigint           not null, primary key
#  aasm_state      :string
#  description     :text
#  private         :boolean          not null
#  private_listing :boolean          default(FALSE)
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  account_id      :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_listings_on_account_id  (account_id)
#  index_listings_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Listing < ApplicationRecord
  self.ignored_columns = ["draft"]
  include AASM

  aasm do
  	state :draft, initial: true
    state :active, :inactive, :closed

    event :publish do
      transitions from: :draft, to: :active
    end

    event :stop do
      transitions from: :active, to: :inactive
    end

    event :start do
      transitions from: :inactive, to: :active
    end

    event :close do
      transitions from: [:active, :inactive], to: :closed
    end

    event :open do
      transitions from: :closed, to: :inactive
    end
  end

  def operator_events
    aasm.events(possible: true).map(&:name) & %i[publish stop start close open]
  end
  
  belongs_to :user
  belongs_to :account
  has_rich_text :description
  has_many :properties, dependent: :destroy

  scope :sorted, ->{ order(updated_at: :desc)}
  scope :account, -> (account) {where(account: account)}
  scope :state, -> (aasm_state) {where(aasm_state: aasm_state)}
  scope :private_listing, -> (private_listing) {where(private_listing: private_listing)}

  validates :title, presence: :true

  accepts_nested_attributes_for :properties
end
