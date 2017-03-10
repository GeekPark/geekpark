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

      t.string :content_type
      t.text :content_source
      t.text :content_rendered

      t.hstore :meta, default: '', index: true

      t.string :source
      t.string :link
      t.string :picture

      t.references :column, index: true

      t.string :state, index: true
      t.boolean :hidden, index: true, default: false

      t.string :tags, array: true, default: [], index: true

      t.datetime :published_at
      t.timestamps
    end

    create_table :comments do |t|
      t.string :content

      t.string :username, index: true
      t.string :state, index: true

      t.string  :commentable_type
      t.integer :commentable_id

      t.references :parent, index: true

      t.timestamps
    end
    add_index :comments, [:commentable_type, :commentable_id]

    create_table :columns do |t|
      t.string :title, index: true
      t.string :description

      t.hstore :meta, default: '', index: true

      # video/article
      t.integer :content_type, index: true

      t.timestamps
    end

    create_table :topic_items do |t|
      t.references :topic, index: true
      t.references :post, index: true
    end

    create_table :topics do |t|
      t.string :title, index: true
      t.string :description

      t.hstore :meta, default: '', index: true

      t.timestamps
    end

    create_table :collection_items do |t|
      t.references :collection, index: true
      t.references :post, index: true
    end

    create_table :collections do |t|
      t.string :title, index: true
      t.string :description

      t.string :banner
      t.string :banner_mobile

      t.hstore :meta, default: '', index: true

      t.timestamps
    end

    create_table :ads do |t|
      t.string :title
      t.string :position, index: true

      t.hstore :meta, default: '', index: true

      t.string :link
      t.string :picture

      t.datetime :active_at
      t.datetime :active_through
      t.timestamps
    end

    create_table :counts do |t|
      t.string  :countable_type
      t.integer :countable_id

      t.integer :count
      t.timestamps
    end
    add_index :counts, [:countable_id, :countable_type]
  end
end
