class Comment < ApplicationRecord
  acts_as_paranoid

  belongs_to :topic

  belongs_to :parent, class_name: 'Comment'
  has_many :children, class_name: 'Comment', foreign_key: 'parent_id'

  enum state: [:normal, :filtered]

  validates_presence_of :content
  validates_presence_of :state
end
