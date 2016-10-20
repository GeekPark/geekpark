# == Schema Information
#
# Table name: topic_items
#
#  id       :integer          not null, primary key
#  topic_id :integer
#  post_id  :integer
#
# Indexes
#
#  index_topic_items_on_post_id   (post_id)
#  index_topic_items_on_topic_id  (topic_id)
#

class TopicItem < ApplicationRecord
  belongs_to :topic
  belongs_to :post
end
