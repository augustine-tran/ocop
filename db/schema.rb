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

ActiveRecord::Schema[7.1].define(version: 2024_03_08_113043) do
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
    t.integer "position"
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

  create_table "assessments", force: :cascade do |t|
    t.integer "submission_id", null: false
    t.string "assessable_type", null: false
    t.integer "assessable_id", null: false
    t.decimal "scores_sum", default: "0.0", null: false
    t.integer "star"
    t.string "status", default: "drafted", null: false
    t.integer "judge_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assessable_type", "assessable_id"], name: "index_assessments_on_assessable"
    t.index ["judge_id"], name: "index_assessments_on_judge_id"
    t.index ["submission_id"], name: "index_assessments_on_submission_id"
  end

  create_table "assistants", force: :cascade do |t|
    t.integer "identity_id", null: false
    t.string "department"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["identity_id"], name: "index_assistants_on_identity_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "title", null: false
    t.string "slug", null: false
    t.integer "parent_id"
    t.integer "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_categories_on_account_id"
    t.index ["parent_id"], name: "index_categories_on_parent_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name", null: false
    t.integer "account_id", null: false
    t.integer "owner_id", null: false
    t.string "registration_name"
    t.string "registration_no"
    t.date "registration_date"
    t.string "legal_type"
    t.string "status", default: "active", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_companies_on_account_id"
    t.index ["owner_id"], name: "index_companies_on_owner_id"
    t.index ["registration_no"], name: "index_companies_on_registration_no", unique: true
  end

  create_table "council_members", force: :cascade do |t|
    t.integer "council_id", null: false
    t.integer "person_id", null: false
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["council_id"], name: "index_council_members_on_council_id"
    t.index ["person_id"], name: "index_council_members_on_person_id"
  end

  create_table "councils", force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "criteria_bucket_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_councils_on_account_id"
    t.index ["criteria_bucket_id"], name: "index_councils_on_criteria_bucket_id"
  end

  create_table "criteria", force: :cascade do |t|
    t.string "title"
    t.integer "criteria_group_id", null: false
    t.integer "parent_id"
    t.string "description"
    t.integer "level"
    t.integer "score"
    t.integer "stars"
    t.integer "star_3"
    t.integer "star_4"
    t.integer "star_5"
    t.boolean "leaf", default: false, null: false
    t.string "status", default: "active", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["criteria_group_id"], name: "index_criteria_on_criteria_group_id"
    t.index ["parent_id"], name: "index_criteria_on_parent_id"
  end

  create_table "criteria_buckets", force: :cascade do |t|
    t.string "name"
    t.integer "account_id", null: false
    t.string "description"
    t.integer "year", default: 2024, null: false
    t.string "status", default: "active", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_criteria_buckets_on_account_id"
  end

  create_table "criteria_groups", force: :cascade do |t|
    t.string "name"
    t.integer "criteria_bucket_id", null: false
    t.string "description"
    t.string "file"
    t.string "status", default: "active", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["criteria_bucket_id"], name: "index_criteria_groups_on_criteria_bucket_id"
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

  create_table "evidences", force: :cascade do |t|
    t.integer "score_id", null: false
    t.integer "criterium_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["criterium_id"], name: "index_evidences_on_criterium_id"
    t.index ["score_id"], name: "index_evidences_on_score_id"
  end

  create_table "final_assessments", force: :cascade do |t|
    t.string "level", default: "district", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "judges", force: :cascade do |t|
    t.integer "identity_id", null: false
    t.string "department"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["identity_id"], name: "index_judges_on_identity_id"
  end

  create_table "ownerships", force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "person_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_ownerships_on_account_id"
    t.index ["person_id"], name: "index_ownerships_on_person_id"
  end

  create_table "panel_assessments", force: :cascade do |t|
    t.string "level", default: "district", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", force: :cascade do |t|
    t.integer "account_id", null: false
    t.string "personable_type", null: false
    t.integer "personable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_people_on_account_id"
    t.index ["personable_type", "personable_id"], name: "index_people_on_personable"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title", null: false
    t.string "slug", null: false
    t.string "status", default: "drafted", null: false
    t.integer "category_id", null: false
    t.integer "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "source"
    t.index ["account_id"], name: "index_posts_on_account_id"
    t.index ["category_id"], name: "index_posts_on_category_id"
    t.index ["slug"], name: "index_posts_on_slug", unique: true
  end

  create_table "products", force: :cascade do |t|
    t.string "title", null: false
    t.string "status", default: "drafted"
    t.string "slug", null: false
    t.integer "stars", default: 0
    t.integer "company_id", null: false
    t.integer "category_id", null: false
    t.integer "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_products_on_account_id"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["company_id"], name: "index_products_on_company_id"
    t.index ["slug"], name: "index_products_on_slug", unique: true
    t.index ["stars"], name: "index_products_on_stars"
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

  create_table "push_subscriptions", force: :cascade do |t|
    t.integer "person_id", null: false
    t.string "endpoint"
    t.string "p256dh_key"
    t.string "auth_key"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["endpoint", "p256dh_key", "auth_key"], name: "idx_on_endpoint_p256dh_key_auth_key_7553014576"
    t.index ["endpoint"], name: "index_push_subscriptions_on_endpoint", unique: true
    t.index ["person_id"], name: "index_push_subscriptions_on_person_id"
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
    t.string "title", null: false
    t.string "description"
    t.integer "assessment_id", null: false
    t.integer "level", default: 0, null: false
    t.integer "stars"
    t.integer "star_3"
    t.integer "star_4"
    t.integer "star_5"
    t.integer "parent_id"
    t.integer "criterium_id", null: false
    t.integer "criterion_id"
    t.decimal "score", default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assessment_id"], name: "index_scores_on_assessment_id"
    t.index ["criterion_id"], name: "index_scores_on_criterion_id"
    t.index ["criterium_id"], name: "index_scores_on_criterium_id"
    t.index ["parent_id"], name: "index_scores_on_parent_id"
  end

  create_table "self_assessments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "identity_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token", default: "", null: false
    t.datetime "last_active_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["identity_id"], name: "index_sessions_on_identity_id"
    t.index ["token"], name: "index_sessions_on_token", unique: true
  end

  create_table "submissions", force: :cascade do |t|
    t.string "name", null: false
    t.integer "council_id", null: false
    t.integer "criteria_group_id", null: false
    t.integer "company_id", null: false
    t.string "description"
    t.string "status", default: "drafted", null: false
    t.decimal "scores_sum", default: "0.0", null: false
    t.integer "star", default: 0, null: false
    t.integer "creator_id"
    t.integer "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_submissions_on_account_id"
    t.index ["company_id"], name: "index_submissions_on_company_id"
    t.index ["council_id"], name: "index_submissions_on_council_id"
    t.index ["creator_id"], name: "index_submissions_on_creator_id"
    t.index ["criteria_group_id"], name: "index_submissions_on_criteria_group_id"
  end

  create_table "tombstones", force: :cascade do |t|
    t.integer "user_id"
    t.integer "judge_id"
    t.json "details", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["judge_id"], name: "index_tombstones_on_judge_id"
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
  add_foreign_key "assessments", "people", column: "judge_id"
  add_foreign_key "assessments", "submissions"
  add_foreign_key "assistants", "identities"
  add_foreign_key "categories", "accounts"
  add_foreign_key "categories", "categories", column: "parent_id"
  add_foreign_key "companies", "accounts"
  add_foreign_key "companies", "people", column: "owner_id"
  add_foreign_key "council_members", "councils"
  add_foreign_key "council_members", "people"
  add_foreign_key "councils", "accounts"
  add_foreign_key "councils", "criteria_buckets"
  add_foreign_key "criteria", "criteria", column: "parent_id"
  add_foreign_key "criteria", "criteria_groups"
  add_foreign_key "criteria_buckets", "accounts"
  add_foreign_key "criteria_groups", "criteria_buckets"
  add_foreign_key "event_details", "events"
  add_foreign_key "events", "people", column: "creator_id"
  add_foreign_key "events", "recordings"
  add_foreign_key "evidences", "criteria"
  add_foreign_key "evidences", "scores"
  add_foreign_key "judges", "identities"
  add_foreign_key "ownerships", "accounts"
  add_foreign_key "ownerships", "people"
  add_foreign_key "people", "accounts"
  add_foreign_key "posts", "accounts"
  add_foreign_key "posts", "categories"
  add_foreign_key "products", "accounts"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "companies"
  add_foreign_key "prompts", "accounts"
  add_foreign_key "push_subscriptions", "people"
  add_foreign_key "recordings", "accounts"
  add_foreign_key "recordings", "people", column: "creator_id"
  add_foreign_key "recordings", "recordings", column: "parent_id"
  add_foreign_key "scores", "criteria"
  add_foreign_key "scores", "criteria", column: "criterion_id"
  add_foreign_key "scores", "scores", column: "parent_id"
  add_foreign_key "sessions", "identities"
  add_foreign_key "submissions", "accounts"
  add_foreign_key "submissions", "companies"
  add_foreign_key "submissions", "councils"
  add_foreign_key "submissions", "criteria_groups"
  add_foreign_key "submissions", "people", column: "creator_id"
  add_foreign_key "tombstones", "judges"
  add_foreign_key "tombstones", "users"
  add_foreign_key "users", "identities"
end
