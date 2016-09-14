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

ActiveRecord::Schema.define(version: 20160914045255) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "collection_items", force: :cascade do |t|
    t.integer "collection_id"
    t.integer "topic_id"
    t.index ["collection_id"], name: "index_collection_items_on_collection_id", using: :btree
    t.index ["topic_id"], name: "index_collection_items_on_topic_id", using: :btree
  end

  create_table "collections", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.string   "banner"
    t.string   "banner_mobile"
    t.hstore   "meta"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["meta"], name: "index_collections_on_meta", using: :btree
    t.index ["title"], name: "index_collections_on_title", using: :btree
  end

  create_table "columns", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.hstore   "meta"
    t.integer  "type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["meta"], name: "index_columns_on_meta", using: :btree
    t.index ["title"], name: "index_columns_on_title", using: :btree
    t.index ["type"], name: "index_columns_on_type", using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.string   "content"
    t.string   "username"
    t.integer  "state"
    t.integer  "topic_id"
    t.integer  "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_comments_on_parent_id", using: :btree
    t.index ["state"], name: "index_comments_on_state", using: :btree
    t.index ["topic_id"], name: "index_comments_on_topic_id", using: :btree
    t.index ["username"], name: "index_comments_on_username", using: :btree
  end

  create_table "topics", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.text     "abstract"
    t.hstore   "meta"
    t.string   "source"
    t.string   "link"
    t.string   "picture"
    t.integer  "column_id"
    t.integer  "state"
    t.boolean  "hidden",     default: false
    t.string   "tags",       default: [],                 array: true
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["column_id"], name: "index_topics_on_column_id", using: :btree
    t.index ["hidden"], name: "index_topics_on_hidden", using: :btree
    t.index ["meta"], name: "index_topics_on_meta", using: :btree
    t.index ["state"], name: "index_topics_on_state", using: :btree
    t.index ["tags"], name: "index_topics_on_tags", using: :btree
    t.index ["title"], name: "index_topics_on_title", using: :btree
  end

end
