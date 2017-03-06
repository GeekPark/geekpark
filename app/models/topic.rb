# == Schema Information
#
# Table name: topics
#
#  id          :integer          not null, primary key
#  title       :string
#  description :string
#  meta        :hstore           default({})
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  deleted_at  :datetime
#
# Indexes
#
#  index_topics_on_deleted_at  (deleted_at)
#  index_topics_on_meta        (meta)
#  index_topics_on_title       (title)
#

class Topic < ApplicationRecord
  include HasMeta
  acts_as_paranoid

  validates_presence_of :title
  validates_presence_of :description

  has_many :topic_items, dependent: :destroy
  has_many :posts, through: :collection_items

  DEFAULT_META = {
    paginate_per: '20',
    management_paginate_per: '10',
    theme_color: '#ff0000'
  }.freeze

  include HasMembers
  def_add_members field: :posts
end
