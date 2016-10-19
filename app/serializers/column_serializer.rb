class ColumnSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :meta
end
