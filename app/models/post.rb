# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string
#  content    :text
#  abstract   :text
#  meta       :hstore
#  source     :string
#  link       :string
#  picture    :string
#  column_id  :integer
#  state      :integer
#  hidden     :boolean          default(FALSE)
#  tags       :string           default([]), is an Array
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#
# Indexes
#
#  index_posts_on_column_id   (column_id)
#  index_posts_on_deleted_at  (deleted_at)
#  index_posts_on_hidden      (hidden)
#  index_posts_on_meta        (meta)
#  index_posts_on_state       (state)
#  index_posts_on_tags        (tags)
#  index_posts_on_title       (title)
#

class Post < ApplicationRecord
  include HasMeta
  acts_as_paranoid

  validates_presence_of :title
  validates_presence_of :column
  validates_presence_of :state

  has_many :comments, dependent: :destroy
  has_many :collection_items, dependent: :destroy
  has_many :collections, through: :collection_items
  belongs_to :column

  enum state: [:draft, :published]

  DEFAULT_META = {
    paginate_per: '20',
    management_paginate_per: '10',
    video_provider: '',
    video_identifier: ''
  }.freeze

  def article?
    !video?
  end

  def video?
    meta['video_provider'].present?
  end
end
