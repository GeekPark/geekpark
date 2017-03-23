# == Schema Information
#
# Table name: ads
#
#  id             :integer          not null, primary key
#  title          :string
#  position       :string
#  meta           :hstore           default({})
#  link           :string
#  picture        :string
#  active_at      :datetime
#  active_through :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  deleted_at     :datetime
#
# Indexes
#
#  index_ads_on_deleted_at  (deleted_at)
#  index_ads_on_meta        (meta)
#  index_ads_on_position    (position)
#

class Ad < ApplicationRecord
  include Countable

  acts_as_paranoid

  add_instance_counter_for :click
  add_instance_counter_for :view

  enumerize :position, in: [
              :banner,
              :logo,
              :top_left,
              :top_right
            ]

  def active?(at: Time.now)
    active_at <= at && active_through >= at
  end

  def self.currently_active
    all.where(
      'active_at <= :now AND active_through >= :now',
      now: Time.now
    )
  end

  def self.at(position)
    all.with_position(position)
  end

  def self.currently_active_by_position
    all.currently_active.group_by(&:position)
  end
end
