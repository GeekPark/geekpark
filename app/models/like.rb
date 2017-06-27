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
# Indexes
#
#  index_likes_on_user_id_and_target_type_and_target_id  (user_id,target_type,target_id)
#

class Like < ApplicationRecord
  belongs_to :target, polymorphic: true
end
