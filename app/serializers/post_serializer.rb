class PostSerializer < ApplicationSerializer
  attributes :id,
             :title,
             :abstract,
             :content_type,
             :content,
             :meta,
             :source,
             :link,
             :picture,
             :state,
             :tags,
             :published_at

  has_one :column
end
