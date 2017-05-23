# == Schema Information
#
# Table name: columns
#
#  id           :integer          not null, primary key
#  title        :string
#  description  :string
#  content_type :integer
#  banner_id    :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  deleted_at   :datetime
#
# Indexes
#
#  index_columns_on_banner_id     (banner_id)
#  index_columns_on_content_type  (content_type)
#  index_columns_on_deleted_at    (deleted_at)
#  index_columns_on_title         (title)
#

class Column < ApplicationRecord
  acts_as_paranoid

  validates_presence_of :title
  validates_presence_of :description

  has_many :posts, dependent: :restrict_with_exception

  enum content_type: [:normal, :video]

  scope :hearsay, -> { where(title: 'hearsay') }

  include HasMembers
  def_add_members field: :posts

  scope :hearsay, -> { where(title: '捕风捉影') }
end
