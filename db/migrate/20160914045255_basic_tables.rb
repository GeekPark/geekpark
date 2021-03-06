# coding: utf-8

class BasicTables < ActiveRecord::Migration[5.0]
  def change
    reversible do |dir|
      dir.up do
        execute 'CREATE EXTENSION hstore'
      end
      dir.down do
        execute 'DROP EXTENSION hstore'
      end
    end

    create_table :posts do |t|
      t.string :title, index: true
      t.text :abstract

      t.integer :content_type, default: 0
      t.integer :post_type, default: 0
      t.text :content_source
      t.text :content_rendered

      t.string :source
      t.string :link
      t.integer :cover_id

      t.json :provider

      t.references :column, index: true

      t.integer :state, index: true, default: 0
      t.boolean :hidden, index: true, default: false

      t.string :tags,    array: true, default: [], index: true
      t.string :authors, array: true, default: [], index: true

      t.datetime :published_at
      t.timestamps
    end

    create_table :comments do |t|
      t.string  :content

      t.string  :commenter, index: true
      t.integer :state,     index: true, default: 0

      t.integer :upvote,                 default: 0
      t.integer :depth,                  default: 0

      t.string  :commentable_type
      t.integer :commentable_id

      t.references :parent, index: true

      t.timestamps
    end
    add_index :comments, [:commentable_type, :commentable_id]

    create_table :columns do |t|
      t.string :title, index: true
      t.string :description

      # video/article
      t.integer :content_type, index: true
      t.integer :banner_id, index: true

      t.timestamps
    end

    create_table :topic_items do |t|
      t.references :topic, index: true
      t.references :post, index: true
    end

    create_table :topics do |t|
      t.string :title, index: true
      t.string :description

      t.integer :banner_id, index: true

      t.timestamps
    end

    create_table :collection_items do |t|
      t.references :collection, index: true
      t.references :post, index: true
    end

    create_table :collections do |t|
      t.string :title, index: true
      t.string :description

      t.integer :banner_id, index: true

      t.timestamps
    end

    create_table :ads do |t|
      t.string :title
      t.integer :position, index: true, default: 0

      t.string :link
      t.integer :cover_id, index: true

      t.datetime :active_at
      t.datetime :active_through
      t.timestamps
    end

    create_table :counts do |t|
      t.references :countable, polymorphic: true, index: true

      t.integer :count
      t.timestamps
    end

    create_table :tags do |t|
      t.string :name

      t.integer :post_count, default: 0
      t.datetime :used_at
      t.timestamps
    end
    add_index :tags, :name, unique: true

    create_table :images do |t|
      t.string :file
      t.string :usage
      t.timestamps
    end
  end
end
