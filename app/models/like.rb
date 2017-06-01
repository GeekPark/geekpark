# == Schema Information
#
# Table name: likes
#
#  id          :integer          not null, primary key
#  user_id     :string
#  target_type :string
#  target_id   :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Like < ApplicationRecord
  belongs_to :target, polymorphic: true
end
