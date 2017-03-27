# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  content          :string
#  user_id          :integer
#  state            :integer          default("normal")
#  commentable_type :string
#  commentable_id   :integer
#  parent_id        :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  deleted_at       :datetime
#

class AdminCommentSerializer < CommentSerializer
  attributes :commentable_type, :commentable_id, :state
end
