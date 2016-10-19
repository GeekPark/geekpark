# == Schema Information
#
# Table name: collection_items
#
#  id            :integer          not null, primary key
#  collection_id :integer
#  post_id       :integer
#
# Indexes
#
#  index_collection_items_on_collection_id  (collection_id)
#  index_collection_items_on_post_id        (post_id)
#

class CollectionItem < ApplicationRecord
  belongs_to :collection
  belongs_to :post
end
