class Collection < ApplicationRecord
  acts_as_paranoid

  has_many :collection_items, dependent: :destroy
  has_many :topics, through: :collection_items

  validates_presence_of :title
  validates_presence_of :description
end
