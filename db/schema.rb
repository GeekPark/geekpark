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

ActiveRecord::Schema.define(version: 20170601021434) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "ads", force: :cascade do |t|
    t.string   "title"
    t.integer  "position",       default: 0
    t.string   "link"
    t.integer  "cover_id"
    t.datetime "active_at"
    t.datetime "active_through"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.datetime "deleted_at"
    t.index ["cover_id"], name: "index_ads_on_cover_id", using: :btree
    t.index ["deleted_at"], name: "index_ads_on_deleted_at", using: :btree
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
    t.integer  "banner_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "deleted_at"
    t.index ["banner_id"], name: "index_collections_on_banner_id", using: :btree
    t.index ["deleted_at"], name: "index_collections_on_deleted_at", using: :btree
    t.index ["title"], name: "index_collections_on_title", using: :btree
  end

  create_table "columns", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "content_type"
    t.integer  "banner_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.datetime "deleted_at"
    t.index ["banner_id"], name: "index_columns_on_banner_id", using: :btree
    t.index ["content_type"], name: "index_columns_on_content_type", using: :btree
    t.index ["deleted_at"], name: "index_columns_on_deleted_at", using: :btree
    t.index ["title"], name: "index_columns_on_title", using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.string   "content"
    t.string   "commenter"
    t.integer  "state",            default: 0
    t.integer  "upvote",           default: 0
    t.integer  "depth",            default: 0
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.integer  "parent_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.datetime "deleted_at"
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id", using: :btree
    t.index ["commenter"], name: "index_comments_on_commenter", using: :btree
    t.index ["deleted_at"], name: "index_comments_on_deleted_at", using: :btree
    t.index ["parent_id"], name: "index_comments_on_parent_id", using: :btree
    t.index ["state"], name: "index_comments_on_state", using: :btree
  end

  create_table "counts", force: :cascade do |t|
    t.string   "countable_type"
    t.integer  "countable_id"
    t.integer  "count"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["countable_type", "countable_id"], name: "index_counts_on_countable_type_and_countable_id", using: :btree
  end

  create_table "images", force: :cascade do |t|
    t.string   "file"
    t.string   "usage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.string   "user_id"
    t.string   "target_type"
    t.string   "target_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id", "target_type", "target_id"], name: "index_likes_on_user_id_and_target_type_and_target_id", using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "abstract"
    t.integer  "content_type",     default: 0
    t.integer  "post_type",        default: 0
    t.text     "content_source"
    t.text     "content_rendered"
    t.string   "source"
    t.string   "link"
    t.integer  "cover_id"
    t.json     "provider"
    t.integer  "column_id"
    t.integer  "state",            default: 0
    t.boolean  "hidden",           default: false
    t.string   "tags",             default: [],                 array: true
    t.string   "authors",          default: [],                 array: true
    t.datetime "published_at"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.datetime "deleted_at"
    t.integer  "views"
    t.boolean  "recommended",      default: false
    t.index ["authors"], name: "index_posts_on_authors", using: :btree
    t.index ["column_id"], name: "index_posts_on_column_id", using: :btree
    t.index ["deleted_at"], name: "index_posts_on_deleted_at", using: :btree
    t.index ["hidden"], name: "index_posts_on_hidden", using: :btree
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

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.integer  "post_count", default: 0
    t.datetime "used_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_tags_on_deleted_at", using: :btree
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
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
    t.integer  "banner_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "deleted_at"
    t.index ["banner_id"], name: "index_topics_on_banner_id", using: :btree
    t.index ["deleted_at"], name: "index_topics_on_deleted_at", using: :btree
    t.index ["title"], name: "index_topics_on_title", using: :btree
  end

end
