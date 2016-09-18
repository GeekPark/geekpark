class Column < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :description

  has_many :topics

  enum type: [:normal, :video]
end
