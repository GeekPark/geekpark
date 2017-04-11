# == Schema Information
#
# Table name: posts
#
#  id               :integer          not null, primary key
#  title            :string
#  abstract         :text
#  content_type     :integer          default("html")
#  content_source   :text
#  content_rendered :text
#  meta             :hstore           default({})
#  source           :string
#  link             :string
#  picture          :string
#  column_id        :integer
#  state            :integer          default("unpublished")
#  hidden           :boolean          default(FALSE)
#  tags             :string           default([]), is an Array
#  published_at     :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  deleted_at       :datetime
#
# Indexes
#
#  index_posts_on_column_id   (column_id)
#  index_posts_on_deleted_at  (deleted_at)
#  index_posts_on_hidden      (hidden)
#  index_posts_on_meta        (meta)
#  index_posts_on_state       (state)
#  index_posts_on_tags        (tags)
#  index_posts_on_title       (title)
#

class Post < ApplicationRecord
  include HasMeta
  include SmartFilterable
  include Countable
  include ProcessPostMeta

  acts_as_paranoid

  add_instance_counter_for :click
  add_instance_counter_for :publishing
  add_instance_counter_for :sharing

  validates_presence_of :title
  validates_presence_of :column
  validates_presence_of :state, :content_type

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :collection_items, dependent: :destroy
  has_many :collections, through: :collection_items
  belongs_to :column

  before_save :render_content

  enum state: [:unpublished, :published, :closed]
  enum content_type: [:html, :markdown, :plain]

  scope :homepage, -> { published }

  def article?
    !video?
  end

  def video?
    meta['video_provider'].present?
  end

  def content
    content_rendered || render_content
  end

  def publish!
    self.state = :published
    self.published_at = Time.now
    save
    incr_publishing_count
  end

  def publish_later(till:)
    DelayedPublishJob
      .set(wait_until: till)
      .perform_later(self)
  end

  def unpublish!
    self.state = :unpublished
    self.published_at = nil
    save
    incr_publishing_count(-1)
  end

  def close!
    self.state = :closed
    save
  end

  private

  def render_content
    case content_type.intern
    when :html
      self.content_rendered = content_source
    when :markdown
      self.content_rendered = MarkdownEngine.render_html(content_source)
    when :plain
      self.content_rendered = "<p>#{content_source}</p>"
    end
  end
end
