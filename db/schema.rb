# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_11_29_111835) do
  create_table "accounts", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.string "name", null: false
    t.string "phone"
    t.string "email"
    t.string "address"
    t.string "addressable_type", null: false
    t.integer "addressable_id", null: false
    t.integer "ward_id"
    t.integer "district_id"
    t.integer "province_id"
    t.string "note"
    t.integer "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_addresses_on_account_id"
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable"
    t.index ["district_id"], name: "index_addresses_on_district_id"
    t.index ["province_id"], name: "index_addresses_on_province_id"
    t.index ["ward_id"], name: "index_addresses_on_ward_id"
  end

  create_table "administrative_units", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "administratorships", force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "person_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_administratorships_on_account_id"
    t.index ["person_id"], name: "index_administratorships_on_person_id"
  end

  create_table "clients", force: :cascade do |t|
    t.integer "identity_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["identity_id"], name: "index_clients_on_identity_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.boolean "is_primary", default: false, null: false
    t.string "registration_name"
    t.string "registration_no"
    t.date "registration_date"
    t.string "legal_type"
    t.string "status", default: "active", null: false
    t.integer "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_companies_on_account_id"
    t.index ["registration_no"], name: "index_companies_on_registration_no", unique: true
  end

  create_table "criteria", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "product_group", default: "group1", null: false
    t.integer "parent_id"
    t.integer "year", default: 2024, null: false
    t.integer "level"
    t.integer "score"
    t.boolean "leaf", default: false, null: false
    t.string "status", default: "active", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_criteria_on_parent_id"
  end

  create_table "event_details", force: :cascade do |t|
    t.integer "event_id", null: false
    t.boolean "title_changed", default: false, null: false
    t.boolean "description_changed", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_details_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.integer "recording_id", null: false
    t.string "recordable_type", null: false
    t.integer "recordable_id", null: false
    t.string "recordable_previous_type"
    t.integer "recordable_previous_id"
    t.integer "creator_id", null: false
    t.string "action", null: false
    t.string "status_was"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_events_on_creator_id"
    t.index ["recordable_previous_type", "recordable_previous_id"], name: "index_events_on_recordable_previous"
    t.index ["recordable_type", "recordable_id"], name: "index_events_on_recordable"
    t.index ["recording_id"], name: "index_events_on_recording_id"
  end

  create_table "identities", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.boolean "verified", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_identities_on_email", unique: true
  end

  create_table "ownerships", force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "person_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_ownerships_on_account_id"
    t.index ["person_id"], name: "index_ownerships_on_person_id"
  end

  create_table "people", force: :cascade do |t|
    t.integer "account_id", null: false
    t.string "personable_type", null: false
    t.integer "personable_id", null: false
    t.string "role", default: "user", null: false
    t.string "string", default: "user", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_people_on_account_id"
    t.index ["personable_type", "personable_id"], name: "index_people_on_personable"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "status"
    t.integer "company_id", null: false
    t.integer "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_products_on_account_id"
    t.index ["company_id"], name: "index_products_on_company_id"
    t.index ["status"], name: "index_products_on_status"
  end

  create_table "prompts", force: :cascade do |t|
    t.string "title"
    t.binary "prompt_image"
    t.integer "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_prompts_on_account_id"
  end

  create_table "recordings", force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "creator_id", null: false
    t.integer "parent_id"
    t.string "recordable_type", null: false
    t.integer "recordable_id", null: false
    t.string "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_recordings_on_account_id"
    t.index ["creator_id"], name: "index_recordings_on_creator_id"
    t.index ["parent_id"], name: "index_recordings_on_parent_id"
    t.index ["recordable_type", "recordable_id"], name: "index_recordings_on_recordable"
  end

  create_table "scores", force: :cascade do |t|
    t.string "scorable_type", null: false
    t.integer "scorable_id", null: false
    t.string "level", default: "node_roots", null: false
    t.integer "parent_id"
    t.integer "criterium_id", null: false
    t.integer "criterion_id"
    t.integer "score", default: 0, null: false
    t.integer "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_scores_on_account_id"
    t.index ["criterion_id"], name: "index_scores_on_criterion_id"
    t.index ["criterium_id"], name: "index_scores_on_criterium_id"
    t.index ["parent_id"], name: "index_scores_on_parent_id"
    t.index ["scorable_type", "scorable_id"], name: "index_scores_on_scorable"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "identity_id", null: false
    t.string "user_agent"
    t.string "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["identity_id"], name: "index_sessions_on_identity_id"
  end

  create_table "submissions", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "submission_type"
    t.string "product_group", default: "group1", null: false
    t.string "status", default: "active", null: false
    t.string "round", default: "self", null: false
    t.integer "parent_id"
    t.integer "company_id"
    t.integer "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "scores_sum"
    t.index ["account_id"], name: "index_submissions_on_account_id"
    t.index ["company_id"], name: "index_submissions_on_company_id"
    t.index ["parent_id"], name: "index_submissions_on_parent_id"
  end

  create_table "tombstones", force: :cascade do |t|
    t.integer "user_id"
    t.integer "client_id"
    t.json "details", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_tombstones_on_client_id"
    t.index ["user_id"], name: "index_tombstones_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "identity_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["identity_id"], name: "index_users_on_identity_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "addresses", "accounts"
  add_foreign_key "addresses", "administrative_units", column: "district_id"
  add_foreign_key "addresses", "administrative_units", column: "province_id"
  add_foreign_key "addresses", "administrative_units", column: "ward_id"
  add_foreign_key "administratorships", "accounts"
  add_foreign_key "administratorships", "people"
  add_foreign_key "clients", "identities"
  add_foreign_key "companies", "accounts"
  add_foreign_key "criteria", "criteria", column: "parent_id"
  add_foreign_key "event_details", "events"
  add_foreign_key "events", "people", column: "creator_id"
  add_foreign_key "events", "recordings"
  add_foreign_key "ownerships", "accounts"
  add_foreign_key "ownerships", "people"
  add_foreign_key "people", "accounts"
  add_foreign_key "products", "accounts"
  add_foreign_key "products", "companies"
  add_foreign_key "prompts", "accounts"
  add_foreign_key "recordings", "accounts"
  add_foreign_key "recordings", "people", column: "creator_id"
  add_foreign_key "recordings", "recordings", column: "parent_id"
  add_foreign_key "scores", "accounts"
  add_foreign_key "scores", "criteria"
  add_foreign_key "scores", "criteria", column: "criterion_id"
  add_foreign_key "scores", "scores", column: "parent_id"
  add_foreign_key "sessions", "identities"
  add_foreign_key "submissions", "accounts"
  add_foreign_key "submissions", "companies"
  add_foreign_key "submissions", "submissions", column: "parent_id"
  add_foreign_key "tombstones", "clients"
  add_foreign_key "tombstones", "users"
  add_foreign_key "users", "identities"
end
