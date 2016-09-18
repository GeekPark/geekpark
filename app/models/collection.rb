class Collection < ApplicationRecord
  has_many :collection_items
  has_many :topics, through: :collection_items

  validates_presence_of :title
  validates_presence_of :description
end
