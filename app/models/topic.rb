# == Schema Information
#
# Table name: topics
#
#  id          :integer          not null, primary key
#  title       :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  deleted_at  :datetime
#
# Indexes
#
#  index_topics_on_deleted_at  (deleted_at)
#  index_topics_on_title       (title)
#

class Topic < ApplicationRecord
  acts_as_paranoid

  validates_presence_of :title
  validates_presence_of :description

  has_many :topic_items, dependent: :destroy
  has_many :posts, through: :topic_items

  include HasMembers
  def_add_members   field: :posts
  def_reset_members field: :posts
end
