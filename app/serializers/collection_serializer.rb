class CollectionSerializer < ApplicationSerializer
  attributes :id, :title, :description
  attribute :meta, if: :manager?

  has_many :topics, serializer: ShortTopicSerializer
end
