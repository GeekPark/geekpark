require 'rails_helper'

RSpec.describe Column, type: :model do
  let!(:column) { create(:column) }

  describe 'add members' do
    it 'correctly add members' do
      n = 3
      create_list(:post, 3, column: column)
      posts = create_list(:post, n)
      expect {
        column.add_members(posts.pluck(:id))
      }.to change { column.posts.count }.by(n)
      expect(column.posts).to include(*posts)
    end

    it 'denies invalid members' do
      create_list(:post, 3, column: column)
      posts = create_list(:post, 4)
      expect {
        expect {
          column.add_members([*posts.pluck(:id), 999_999_999 + 1])
        }.to raise_error(ActiveRecord::RecordNotFound)
      }.not_to change { column.posts.count }
    end
  end
end
