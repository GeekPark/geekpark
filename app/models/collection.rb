# == Schema Information
#
# Table name: collections
#
#  id            :integer          not null, primary key
#  title         :string
#  description   :string
#  banner        :string
#  banner_mobile :string
#  meta          :hstore
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  deleted_at    :datetime
#
# Indexes
#
#  index_collections_on_deleted_at  (deleted_at)
#  index_collections_on_meta        (meta)
#  index_collections_on_title       (title)
#

class Collection < ApplicationRecord
  acts_as_paranoid

  has_many :collection_items, dependent: :destroy
  has_many :topics, through: :collection_items

  validates_presence_of :title
  validates_presence_of :description

  before_save :fill_in_default_meta

  META_VARIABLES = {
    paginate_per: '10',
    management_paginate_per: '10',
    tag_visibility: 'false'
  }.freeze

  def reset_members(topic_ids)
    topics.replace Topic.find(topic_ids)
    save
  end

  def add_members(topics_ids)
    topics << Topic.find(topics_ids)
    save
  end

  private

  def fill_in_default_meta
    self.meta = {} if meta.nil?
    META_VARIABLES.each do |var, value|
      next if meta[var].present?
      meta[var] = value
    end
  end
end
