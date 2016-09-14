class Collection < ApplicationRecord
  has_and_belongs_to_many :topics

  validates_presence_of :title
  validates_presence_of :description
end
