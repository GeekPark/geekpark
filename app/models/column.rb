class Column < ApplicationRecord
  has_many :topics

  enum type: [:normal, :video]
end
