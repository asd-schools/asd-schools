# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160912115931) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "school_id",                             null: false
    t.string   "review_type",                           null: false
    t.string   "child_characteristics",                              array: true
    t.integer  "score"
    t.string   "pros",                                  null: false
    t.string   "cons",                                  null: false
    t.string   "comments",                              null: false
    t.boolean  "published",             default: false, null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "contact",               default: "",    null: false
  end

  create_table "schools", force: :cascade do |t|
    t.string  "name",                                           null: false
    t.string  "suburb",                                         null: false
    t.string  "address",                                        null: false
    t.string  "post_code",                                      null: false
    t.string  "state",                                          null: false
    t.string  "school_type",                                    null: false
    t.string  "year_range",                                     null: false
    t.integer "total_enrollments",                              null: false
    t.integer "fulltime_equivalent_enrollments",                null: false
    t.integer "female_enrollments",                             null: false
    t.integer "male_enrollments",                               null: false
    t.string  "url",                                            null: false
    t.point   "location",                                       null: false
    t.string  "geo_supplier",                                   null: false
    t.string  "sector",                                         null: false
    t.string  "autism_characteristics",          default: "",   null: false
    t.boolean "publish_new_reviews_by_default",  default: true, null: false
  end

  create_table "spatial_ref_sys", primary_key: "srid", id: :integer, force: :cascade do |t|
    t.string  "auth_name", limit: 256
    t.integer "auth_srid"
    t.string  "srtext",    limit: 2048
    t.string  "proj4text", limit: 2048
  end

end
