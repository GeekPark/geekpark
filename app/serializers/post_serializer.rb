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
#  index_posts_on_state       (state)
#  index_posts_on_tags        (tags)
#  index_posts_on_title       (title)
#

class PostSerializer < ApplicationSerializer
  attributes :id,
             :title,
             :abstract,
             :content,
             :cover_url,
             :source,
             :link,
             :tags,
             :published_at,
             :extra

  has_one :column
end
