# == Schema Information
#
# Table name: collections
#
#  id            :integer          not null, primary key
#  title         :string
#  description   :string
#  banner        :string
#  banner_mobile :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  deleted_at    :datetime
#
# Indexes
#
#  index_collections_on_deleted_at  (deleted_at)
#  index_collections_on_title       (title)
#

class CollectionSerializer < ApplicationSerializer
  attributes :id, :title, :description

  has_many :posts, serializer: ShortPostSerializer
end
