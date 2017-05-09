# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string
#  post_count :integer          default(0)
#  used_at    :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#
# Indexes
#
#  index_tags_on_deleted_at  (deleted_at)
#  index_tags_on_name        (name) UNIQUE
#

class Tag < ApplicationRecord
  acts_as_paranoid

  include SmartFilterable

  validates :name, uniqueness: true

  scope :order_by_freq,      -> { order(count: :desc) }
  scope :order_by_last_used, -> { order(used_at: :desc) }

  def self.touch(tags)
    return if tags.empty?
    conn = ActiveRecord::Base.connection
    now = conn.quote(Time.now)
    header = 'INSERT INTO tags ' \
             '(name, post_count, used_at, created_at, updated_at)'
    footer = 'ON CONFLICT (name) DO UPDATE SET ' \
             'post_count = EXCLUDED.post_count + 1, ' \
             "used_at = #{now};"
    rows = tags.compact
               .map(&:to_s)
               .map { |t| conn.quote(t) }
               .map { |t| "(#{t}, 1, #{now}, #{now}, #{now})" }
               .join(", \n")
    conn.execute("#{header} VALUES\n#{rows}\n#{footer}")
  end

  def self.untouch(tags)
    Tag.where(name: tags).update_all(
      'post_count = GREATEST(post_count - 1, 0)'
    )
  end
end
