class Topic < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :column
  validates_presence_of :state

  has_many :comments
  has_many :collection_items
  has_many :collections, through: :collection_items
  belongs_to :column

  enum state: [:draft, :published]

  def article?
    !video?
  end

  def video?
    meta['video_provider'].present?
  end
end
