# == Schema Information
#
# Table name: columns
#
#  id           :integer          not null, primary key
#  title        :string
#  description  :string
#  meta         :hstore
#  content_type :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  deleted_at   :datetime
#
# Indexes
#
#  index_columns_on_content_type  (content_type)
#  index_columns_on_deleted_at    (deleted_at)
#  index_columns_on_meta          (meta)
#  index_columns_on_title         (title)
#

class ColumnSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :meta

  has_many :posts, serializer: ShortPostSerializer
end
