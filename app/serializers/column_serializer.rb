class ColumnSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :meta

  has_many :posts, serializer: ShortPostSerializer
end
