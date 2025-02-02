# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_07_025749) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_invitations", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "invited_by_id"
    t.string "token"
    t.string "name"
    t.string "email"
    t.jsonb "roles", default: {}, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_account_invitations_on_account_id"
    t.index ["invited_by_id"], name: "index_account_invitations_on_invited_by_id"
    t.index ["token"], name: "index_account_invitations_on_token", unique: true
  end

  create_table "account_users", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "user_id"
    t.jsonb "roles", default: {}, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_account_users_on_account_id"
    t.index ["user_id"], name: "index_account_users_on_user_id"
  end

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.bigint "owner_id"
    t.boolean "personal", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "processor"
    t.string "processor_id"
    t.datetime "trial_ends_at"
    t.string "card_type"
    t.string "card_last4"
    t.string "card_exp_month"
    t.string "card_exp_year"
    t.text "extra_billing_info"
    t.string "domain"
    t.string "subdomain"
    t.index ["owner_id"], name: "index_accounts_on_owner_id"
  end

  create_table "action_text_embeds", force: :cascade do |t|
    t.string "url"
    t.jsonb "fields"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "activities", force: :cascade do |t|
    t.datetime "due_date"
    t.string "status"
    t.text "comment"
    t.string "event"
    t.bigint "owner_id"
    t.bigint "account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_activities_on_account_id"
    t.index ["owner_id"], name: "index_activities_on_owner_id"
  end

  create_table "ahoy_events", force: :cascade do |t|
    t.bigint "visit_id"
    t.bigint "user_id"
    t.string "name"
    t.jsonb "properties"
    t.datetime "time"
    t.index ["name", "time"], name: "index_ahoy_events_on_name_and_time"
    t.index ["properties"], name: "index_ahoy_events_on_properties", opclass: :jsonb_path_ops, using: :gin
    t.index ["user_id"], name: "index_ahoy_events_on_user_id"
    t.index ["visit_id"], name: "index_ahoy_events_on_visit_id"
  end

  create_table "ahoy_visits", force: :cascade do |t|
    t.string "visit_token"
    t.string "visitor_token"
    t.bigint "user_id"
    t.string "ip"
    t.text "user_agent"
    t.text "referrer"
    t.string "referring_domain"
    t.text "landing_page"
    t.string "browser"
    t.string "os"
    t.string "device_type"
    t.string "country"
    t.string "region"
    t.string "city"
    t.float "latitude"
    t.float "longitude"
    t.string "utm_source"
    t.string "utm_medium"
    t.string "utm_term"
    t.string "utm_content"
    t.string "utm_campaign"
    t.string "app_version"
    t.string "os_version"
    t.string "platform"
    t.datetime "started_at"
    t.index ["user_id"], name: "index_ahoy_visits_on_user_id"
    t.index ["visit_token"], name: "index_ahoy_visits_on_visit_token", unique: true
  end

  create_table "announcements", force: :cascade do |t|
    t.string "kind"
    t.string "title"
    t.datetime "published_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "api_tokens", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "token"
    t.string "name"
    t.jsonb "metadata", default: {}
    t.boolean "transient", default: false
    t.datetime "last_used_at"
    t.datetime "expires_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["token"], name: "index_api_tokens_on_token", unique: true
    t.index ["user_id"], name: "index_api_tokens_on_user_id"
  end

  create_table "contact_activities", force: :cascade do |t|
    t.bigint "contact_id", null: false
    t.bigint "activity_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["activity_id"], name: "index_contact_activities_on_activity_id"
    t.index ["contact_id"], name: "index_contact_activities_on_contact_id"
  end

  create_table "contact_listing_invitations", force: :cascade do |t|
    t.bigint "listing_invitation_id", null: false
    t.bigint "contact_id", null: false
    t.index ["contact_id"], name: "index_contact_listing_invitations_on_contact_id"
    t.index ["listing_invitation_id"], name: "index_contact_listing_invitations_on_listing_invitation_id"
  end

  create_table "contact_lists", force: :cascade do |t|
    t.bigint "contact_id"
    t.bigint "list_id"
    t.index ["contact_id"], name: "index_contact_lists_on_contact_id"
    t.index ["list_id"], name: "index_contact_lists_on_list_id"
  end

  create_table "contact_memberships", force: :cascade do |t|
    t.bigint "membership_id", null: false
    t.bigint "contact_id", null: false
    t.index ["contact_id"], name: "index_contact_memberships_on_contact_id"
    t.index ["membership_id"], name: "index_contact_memberships_on_membership_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "email"
    t.string "phone"
    t.string "first_name"
    t.string "last_name"
    t.bigint "account_id", null: false
    t.bigint "user_id"
    t.bigint "owner_id"
    t.string "company"
    t.jsonb "role"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_contacts_on_account_id"
    t.index ["owner_id"], name: "index_contacts_on_owner_id"
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "listing_activities", force: :cascade do |t|
    t.bigint "listing_id", null: false
    t.bigint "activity_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["activity_id"], name: "index_listing_activities_on_activity_id"
    t.index ["listing_id"], name: "index_listing_activities_on_listing_id"
  end

  create_table "listing_documents", force: :cascade do |t|
    t.jsonb "document_data"
    t.bigint "listing_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["listing_id"], name: "index_listing_documents_on_listing_id"
  end

  create_table "listing_images", force: :cascade do |t|
    t.jsonb "image_data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "listing_id", null: false
    t.index ["listing_id"], name: "index_listing_images_on_listing_id"
  end

  create_table "listing_invitations", force: :cascade do |t|
    t.bigint "listing_id", null: false
    t.bigint "sender_id", null: false
    t.string "email"
    t.string "token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.jsonb "roles"
    t.index ["listing_id"], name: "index_listing_invitations_on_listing_id"
    t.index ["sender_id"], name: "index_listing_invitations_on_sender_id"
  end

  create_table "listing_secure_documents", force: :cascade do |t|
    t.jsonb "secure_document_data"
    t.bigint "listing_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["listing_id"], name: "index_listing_secure_documents_on_listing_id"
  end

  create_table "listings", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "description"
    t.bigint "account_id", null: false
    t.string "aasm_state"
    t.boolean "private_listing", default: false
    t.datetime "active_at"
    t.datetime "inactive_at"
    t.datetime "closed_at"
    t.bigint "owner_id"
    t.float "price"
    t.boolean "hide_price"
    t.float "cap_rate"
    t.float "noi"
    t.bigint "nda_id"
    t.string "investment_type"
    t.index ["account_id"], name: "index_listings_on_account_id"
    t.index ["nda_id"], name: "index_listings_on_nda_id"
    t.index ["owner_id"], name: "index_listings_on_owner_id"
  end

  create_table "lists", force: :cascade do |t|
    t.bigint "owner_id"
    t.string "name"
    t.bigint "account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_lists_on_account_id"
    t.index ["owner_id"], name: "index_lists_on_owner_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "listing_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "roles"
    t.boolean "secure_access"
    t.index ["listing_id"], name: "index_memberships_on_listing_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "nda_signings", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "listing_id", null: false
    t.bigint "user_id", null: false
    t.datetime "signed_on"
    t.text "content"
    t.string "signature"
    t.string "ip_address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_nda_signings_on_account_id"
    t.index ["listing_id"], name: "index_nda_signings_on_listing_id"
    t.index ["user_id"], name: "index_nda_signings_on_user_id"
  end

  create_table "ndas", force: :cascade do |t|
    t.string "name"
    t.text "content"
    t.bigint "account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_ndas_on_account_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "recipient_type", null: false
    t.bigint "recipient_id", null: false
    t.string "type"
    t.jsonb "params"
    t.datetime "read_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "interacted_at"
    t.index ["account_id"], name: "index_notifications_on_account_id"
    t.index ["recipient_type", "recipient_id"], name: "index_notifications_on_recipient_type_and_recipient_id"
  end

  create_table "pay_charges", force: :cascade do |t|
    t.bigint "owner_id"
    t.string "processor", null: false
    t.string "processor_id", null: false
    t.integer "amount", null: false
    t.integer "amount_refunded"
    t.string "card_type"
    t.string "card_last4"
    t.string "card_exp_month"
    t.string "card_exp_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "owner_type"
    t.index ["owner_id"], name: "index_pay_charges_on_owner_id"
  end

  create_table "pay_subscriptions", id: :serial, force: :cascade do |t|
    t.integer "owner_id"
    t.string "name", null: false
    t.string "processor", null: false
    t.string "processor_id", null: false
    t.string "processor_plan", null: false
    t.integer "quantity", default: 1, null: false
    t.datetime "trial_ends_at"
    t.datetime "ends_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "status"
    t.string "owner_type"
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.integer "amount", default: 0, null: false
    t.string "interval"
    t.jsonb "details", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "trial_period_days", default: 0
  end

  create_table "properties", force: :cascade do |t|
    t.string "name"
    t.string "address1"
    t.string "address2"
    t.string "address_city"
    t.string "address_state"
    t.string "address_zip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "primary_type"
    t.string "secondary_type"
    t.string "asset_class"
    t.string "rent_type"
    t.integer "units"
    t.integer "sf"
    t.integer "floors"
    t.integer "buildings"
    t.float "land_area"
    t.string "zoning"
    t.float "latitude"
    t.float "longitude"
    t.string "address"
    t.jsonb "address_object"
    t.integer "year_built"
    t.integer "rsf"
    t.integer "occupancy"
    t.integer "parking_spaces"
    t.integer "frontage"
    t.string "apn"
    t.bigint "account_id"
    t.text "highlights"
    t.index ["account_id"], name: "index_properties_on_account_id"
  end

  create_table "property_contacts", force: :cascade do |t|
    t.bigint "property_id", null: false
    t.bigint "contact_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["contact_id"], name: "index_property_contacts_on_contact_id"
    t.index ["property_id"], name: "index_property_contacts_on_property_id"
  end

  create_table "property_images", force: :cascade do |t|
    t.jsonb "image_data"
    t.bigint "property_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["property_id"], name: "index_property_images_on_property_id"
  end

  create_table "property_listings", force: :cascade do |t|
    t.bigint "listing_id", null: false
    t.bigint "property_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["listing_id"], name: "index_property_listings_on_listing_id"
    t.index ["property_id"], name: "index_property_listings_on_property_id"
  end

  create_table "user_activities", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "activity_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["activity_id"], name: "index_user_activities_on_activity_id"
    t.index ["user_id"], name: "index_user_activities_on_user_id"
  end

  create_table "user_connected_accounts", force: :cascade do |t|
    t.bigint "user_id"
    t.string "provider"
    t.string "uid"
    t.string "encrypted_access_token"
    t.string "encrypted_access_token_iv"
    t.string "encrypted_access_token_secret"
    t.string "encrypted_access_token_secret_iv"
    t.string "refresh_token"
    t.datetime "expires_at"
    t.text "auth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["encrypted_access_token_iv"], name: "index_connected_accounts_access_token_iv", unique: true
    t.index ["encrypted_access_token_secret_iv"], name: "index_connected_accounts_access_token_secret_iv", unique: true
    t.index ["user_id"], name: "index_user_connected_accounts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "first_name"
    t.string "last_name"
    t.string "time_zone"
    t.datetime "accepted_terms_at"
    t.datetime "accepted_privacy_at"
    t.datetime "announcements_read_at"
    t.boolean "admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.string "preferred_language"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "account_invitations", "accounts"
  add_foreign_key "account_invitations", "users", column: "invited_by_id"
  add_foreign_key "account_users", "accounts"
  add_foreign_key "account_users", "users"
  add_foreign_key "accounts", "users", column: "owner_id"
  add_foreign_key "activities", "accounts"
  add_foreign_key "api_tokens", "users"
  add_foreign_key "contact_activities", "activities"
  add_foreign_key "contact_activities", "contacts"
  add_foreign_key "contact_listing_invitations", "contacts"
  add_foreign_key "contact_listing_invitations", "listing_invitations"
  add_foreign_key "contact_memberships", "contacts"
  add_foreign_key "contact_memberships", "memberships"
  add_foreign_key "contacts", "accounts"
  add_foreign_key "listing_activities", "activities"
  add_foreign_key "listing_activities", "listings"
  add_foreign_key "listing_documents", "listings"
  add_foreign_key "listing_invitations", "listings"
  add_foreign_key "listing_invitations", "users", column: "sender_id"
  add_foreign_key "listing_secure_documents", "listings"
  add_foreign_key "listings", "users", column: "owner_id"
  add_foreign_key "lists", "accounts"
  add_foreign_key "memberships", "listings"
  add_foreign_key "memberships", "users"
  add_foreign_key "nda_signings", "accounts"
  add_foreign_key "nda_signings", "listings"
  add_foreign_key "nda_signings", "users"
  add_foreign_key "ndas", "accounts"
  add_foreign_key "property_contacts", "contacts"
  add_foreign_key "property_contacts", "properties"
  add_foreign_key "property_images", "properties"
  add_foreign_key "property_listings", "listings"
  add_foreign_key "property_listings", "properties"
  add_foreign_key "user_activities", "activities"
  add_foreign_key "user_activities", "users"
  add_foreign_key "user_connected_accounts", "users"
end
