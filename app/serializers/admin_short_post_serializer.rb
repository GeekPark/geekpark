class AdminShortPostSerializer < ApplicationSerializer
  attributes :id, :title, :abstract, :state, :published_at, :post_type
  attribute :column_title do
    object.column&.title
  end
end
