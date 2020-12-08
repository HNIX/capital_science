# == Schema Information
#
# Table name: listings
#
#  id              :bigint           not null, primary key
#  aasm_state      :string
#  active_at       :datetime
#  cap_rate        :float
#  closed_at       :datetime
#  description     :text
#  hide_price      :boolean
#  inactive_at     :datetime
#  investment_type :string
#  noi             :float
#  price           :float
#  private_listing :boolean          default(FALSE)
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  account_id      :bigint           not null
#  nda_id          :bigint
#  owner_id        :bigint
#
# Indexes
#
#  index_listings_on_account_id  (account_id)
#  index_listings_on_nda_id      (nda_id)
#  index_listings_on_owner_id    (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => users.id)
#
class Listing < ApplicationRecord
  include AASM

  belongs_to :owner, class_name: "User"
  belongs_to :account
  belongs_to :nda
  has_rich_text :description
  has_many :listing_images, dependent: :destroy
  has_many :listing_documents, dependent: :destroy
  has_many :listing_secure_documents, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :listing_invitations, dependent: :destroy
  has_many :nda_signings

  has_many :listing_activities
  has_many :activities, through: :listing_activities

  has_many :property_listings
  has_many :properties, through: :property_listings

  scope :sorted, ->{ order(updated_at: :desc)}
  scope :account, -> (account) {where(account: account)}
  scope :state, -> (aasm_state) {where(aasm_state: aasm_state)}
  scope :private_listing, -> (private_listing) {where(private_listing: private_listing)}

  validates :investment_type, presence: :true
  validates :price, presence: :true

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

  def address
    [address1, address_city, address_zip, address_state].compact.join(", ")
  end

  accepts_nested_attributes_for :properties, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :listing_images, allow_destroy: true
  accepts_nested_attributes_for :listing_documents, allow_destroy: true
  accepts_nested_attributes_for :listing_secure_documents, allow_destroy: true
  accepts_nested_attributes_for :listing_invitations
end
