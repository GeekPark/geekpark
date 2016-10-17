class Column < ApplicationRecord
  acts_as_paranoid

  validates_presence_of :title
  validates_presence_of :description

  has_many :topics, dependent: :restrict_with_exception

  enum content_type: [:normal, :video]
end
