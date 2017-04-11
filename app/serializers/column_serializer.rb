# == Schema Information
#
# Table name: columns
#
#  id           :integer          not null, primary key
#  title        :string
#  description  :string
#  content_type :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  deleted_at   :datetime
#
# Indexes
#
#  index_columns_on_content_type  (content_type)
#  index_columns_on_deleted_at    (deleted_at)
#  index_columns_on_title         (title)
#

class ColumnSerializer < ApplicationSerializer
  attributes :id, :title, :description

  has_many :posts, serializer: ShortPostSerializer
end
