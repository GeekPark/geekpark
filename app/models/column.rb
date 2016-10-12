class Column < ApplicationRecord
  acts_as_paranoid

  validates_presence_of :title
  validates_presence_of :description

  has_many :topics, dependent: :restricted_with_exception

  enum type: [:normal, :video]
end
