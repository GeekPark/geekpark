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

class Column < ApplicationRecord
  acts_as_paranoid

  validates_presence_of :title
  validates_presence_of :description

  has_many :topics, dependent: :restrict_with_exception

  enum content_type: [:normal, :video]

  Column::META_VARIABLES = {
    paginate_per: '20',
    management_paginate_per: '10',
    theme_color: '#ff0000'
  }.freeze

  def add_members(ids)
    Topic.where(id: ids).update_all(column_id: id)
  end
end
