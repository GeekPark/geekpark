class CollectionSerializer < ApplicationSerializer
  attributes :id, :title, :description

  has_many :topics, serializer: ShortTopicSerializer
end
