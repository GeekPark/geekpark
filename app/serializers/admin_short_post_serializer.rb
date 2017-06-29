class AdminShortPostSerializer < ApplicationSerializer
  attributes :id,
             :title,
             :abstract,
             :state,
             :published_at,
             :views,
             :recommended
             
  attribute :column_title do
    object.column.title
  end
end
