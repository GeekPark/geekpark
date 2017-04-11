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

ActiveRecord::Schema.define(version: 20170410165313) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "ads", force: :cascade do |t|
    t.string   "title"
    t.integer  "position",       default: 0
    t.hstore   "meta",           default: {}
    t.string   "link"
    t.string   "picture"
    t.datetime "active_at"
    t.datetime "active_through"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_ads_on_deleted_at", using: :btree
    t.index ["meta"], name: "index_ads_on_meta", using: :btree
    t.index ["position"], name: "index_ads_on_position", using: :btree
  end

  create_table "collection_items", force: :cascade do |t|
    t.integer "collection_id"
    t.integer "post_id"
    t.index ["collection_id"], name: "index_collection_items_on_collection_id", using: :btree
    t.index ["post_id"], name: "index_collection_items_on_post_id", using: :btree
  end

  create_table "collections", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.string   "banner"
    t.string   "banner_mobile"
    t.hstore   "meta",          default: {}
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_collections_on_deleted_at", using: :btree
    t.index ["meta"], name: "index_collections_on_meta", using: :btree
    t.index ["title"], name: "index_collections_on_title", using: :btree
  end

  create_table "columns", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.hstore   "meta",         default: {}
    t.integer  "content_type"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.datetime "deleted_at"
    t.index ["content_type"], name: "index_columns_on_content_type", using: :btree
    t.index ["deleted_at"], name: "index_columns_on_deleted_at", using: :btree
    t.index ["meta"], name: "index_columns_on_meta", using: :btree
    t.index ["title"], name: "index_columns_on_title", using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "state",            default: 0
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.integer  "parent_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.datetime "deleted_at"
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id", using: :btree
    t.index ["deleted_at"], name: "index_comments_on_deleted_at", using: :btree
    t.index ["parent_id"], name: "index_comments_on_parent_id", using: :btree
    t.index ["state"], name: "index_comments_on_state", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "counts", force: :cascade do |t|
    t.string   "countable_type"
    t.integer  "countable_id"
    t.integer  "count"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["countable_id", "countable_type"], name: "index_counts_on_countable_id_and_countable_type", using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "abstract"
    t.integer  "content_type",     default: 0
    t.text     "content_source"
    t.text     "content_rendered"
    t.hstore   "meta",             default: {}
    t.string   "source"
    t.string   "link"
    t.string   "picture"
    t.integer  "column_id"
    t.integer  "state",            default: 0
    t.boolean  "hidden",           default: false
    t.string   "tags",             default: [],                 array: true
    t.datetime "published_at"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.datetime "deleted_at"
    t.index ["column_id"], name: "index_posts_on_column_id", using: :btree
    t.index ["deleted_at"], name: "index_posts_on_deleted_at", using: :btree
    t.index ["hidden"], name: "index_posts_on_hidden", using: :btree
    t.index ["meta"], name: "index_posts_on_meta", using: :btree
    t.index ["state"], name: "index_posts_on_state", using: :btree
    t.index ["tags"], name: "index_posts_on_tags", using: :btree
    t.index ["title"], name: "index_posts_on_title", using: :btree
  end

  create_table "settings", force: :cascade do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree
  end

  create_table "topic_items", force: :cascade do |t|
    t.integer "topic_id"
    t.integer "post_id"
    t.index ["post_id"], name: "index_topic_items_on_post_id", using: :btree
    t.index ["topic_id"], name: "index_topic_items_on_topic_id", using: :btree
  end

  create_table "topics", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.hstore   "meta",        default: {}
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_topics_on_deleted_at", using: :btree
    t.index ["meta"], name: "index_topics_on_meta", using: :btree
    t.index ["title"], name: "index_topics_on_title", using: :btree
  end

end
