# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  content          :string
#  commenter        :string
#  state            :integer          default("normal")
#  commentable_type :string
#  commentable_id   :integer
#  parent_id        :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  deleted_at       :datetime
#
# Indexes
#
#  index_comments_on_commentable_type_and_commentable_id  (commentable_type,commentable_id)
#  index_comments_on_deleted_at                           (deleted_at)
#  index_comments_on_parent_id                            (parent_id)
#  index_comments_on_state                                (state)
#  index_comments_on_user_id                              (user_id)
#

class CommentSerializer < ApplicationSerializer
  attributes :id, :content, :commenter, :parent_id, :created_at
end
