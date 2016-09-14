class Column < ApplicationRecord
  has_many :topics

  enum type: [:normal, :video]

  validates_presence_of :title
  validates_presence_of :description
end
