require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '#parent_must_be_consistent_on_commentable' do
    it 'accepts valid parents' do
      comment1 = create(:comment)
      comment2 = create(:comment, commentable: comment1.commentable)

      comment1.update_attributes(parent: comment2)
      expect(comment1.errors).to be_empty
    end

    it 'rejects invalid parents' do
      comment1 = create(:comment)
      comment2 = create(:comment)

      comment1.update_attributes(parent: comment2)
      expect(comment1.errors).not_to be_empty
    end
  end

  describe 'self-join' do
    it 'handles self-join relations correctly' do
      parent = create(:comment)
      children = create_list(:comment,
                             5,
                             parent: parent,
                             commentable: parent.commentable)

      expect(parent.children.map(&:id)).to match_array(children.map(&:id))
      expect(children.map(&:parent)).to match_array([parent] * children.count)
    end
  end
end
