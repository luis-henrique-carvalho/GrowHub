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

ActiveRecord::Schema[8.0].define(version: 2025_05_03_025601) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.uuid "blob_id", null: false
    t.datetime "created_at", null: false
    t.uuid "record_id", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
  end

  create_table "active_storage_blobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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

  create_table "active_storage_variant_records", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "user_id"], name: "index_categories_on_name_and_user_id", unique: true
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "client_bookings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "client_profile_id", null: false
    t.uuid "mentor_availability_id", null: false
    t.uuid "session_id"
    t.integer "status", default: 0, null: false
    t.text "notes"
    t.text "cancellation_reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_profile_id"], name: "index_client_bookings_on_client_profile_id"
    t.index ["mentor_availability_id"], name: "index_client_bookings_on_mentor_availability_id"
    t.index ["mentor_availability_id"], name: "index_client_bookings_on_mentor_availability_id_and_status", unique: true, where: "(status = 1)"
    t.index ["session_id"], name: "index_client_bookings_on_session_id"
  end

  create_table "client_profiles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "profile_name"
    t.integer "career_stage", default: 0, null: false
    t.text "bio"
    t.string "linkedin_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_name"], name: "index_client_profiles_on_profile_name"
    t.index ["user_id"], name: "index_client_profiles_on_user_id"
  end

  create_table "grow_hub_dv", id: :bigint, default: nil, force: :cascade do |t|
    t.timestamptz "created_at", default: -> { "now()" }, null: false
  end

  create_table "mentor_availabilities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "mentor_profile_id", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.boolean "booked"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mentor_profile_id"], name: "index_mentor_availabilities_on_mentor_profile_id"
  end

  create_table "mentor_expertise_areas", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_mentor_expertise_areas_on_name", unique: true
  end

  create_table "mentor_expertise_assignments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "mentor_profile_id", null: false
    t.uuid "mentor_expertise_area_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mentor_expertise_area_id"], name: "index_mentor_expertise_assignments_on_mentor_expertise_area_id"
    t.index ["mentor_profile_id"], name: "index_mentor_expertise_assignments_on_mentor_profile_id"
  end

  create_table "mentor_profiles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "headline"
    t.text "bio"
    t.string "linkedin_url"
    t.integer "years_of_experience"
    t.decimal "hourly_rate"
    t.float "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "profile_name"
    t.index ["profile_name"], name: "index_mentor_profiles_on_profile_name"
    t.index ["user_id"], name: "index_mentor_profiles_on_user_id"
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.bigint "searchable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable"
  end

  create_table "sessions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "mentor_profile_id", null: false
    t.uuid "client_profile_id", null: false
    t.datetime "scheduled_at"
    t.integer "duration_minutes"
    t.string "meeting_url"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_profile_id"], name: "index_sessions_on_client_profile_id"
    t.index ["mentor_profile_id"], name: "index_sessions_on_mentor_profile_id"
  end

  create_table "transactions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.decimal "amount", precision: 12, scale: 3, null: false
    t.integer "transaction_type", default: 0, null: false
    t.string "description"
    t.uuid "category_id", null: false
    t.uuid "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_transactions_on_category_id"
    t.index ["name"], name: "index_transactions_on_name", unique: true
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "cpf"
    t.string "full_name"
    t.string "phone"
    t.date "date_of_birth"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jti"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["status"], name: "index_users_on_status"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "categories", "users"
  add_foreign_key "client_bookings", "client_profiles"
  add_foreign_key "client_bookings", "mentor_availabilities"
  add_foreign_key "client_bookings", "sessions"
  add_foreign_key "client_profiles", "users"
  add_foreign_key "mentor_availabilities", "mentor_profiles"
  add_foreign_key "mentor_expertise_assignments", "mentor_expertise_areas"
  add_foreign_key "mentor_expertise_assignments", "mentor_profiles"
  add_foreign_key "mentor_profiles", "users"
  add_foreign_key "sessions", "client_profiles"
  add_foreign_key "sessions", "mentor_profiles"
  add_foreign_key "transactions", "categories"
  add_foreign_key "transactions", "users"
end
