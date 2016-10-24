require 'rails_helper'

RSpec.describe Collection, type: :model do
  let!(:collection) { create(:collection, :with_posts) }

  describe 'reset_members' do
    it 'reset members correctly' do
      n = 2
      some_posts = create_list(:post, n).pluck(:id)

      collection.reset_members(some_posts)

      expect(collection.posts.count).to eq(n)
      expect(collection.posts.pluck(:id)).to match_array(some_posts)
    end

    it 'reject invalid members' do
      post = create(:post)
      expect {
        expect {
          collection.reset_members([post.id, 999_999])
        }.to raise_error(ActiveRecord::RecordNotFound)
      }.not_to change { collection.posts.count }
    end
  end


  describe 'add_members' do
    it 'add members correctly' do
      n = 3
      post = create_list(:post, n)
      expect {
        collection.add_members([post.pluck(:id)])
      }.to change { collection.posts.count }.by(3)
    end

    it 'reject invalid members' do
      post = create(:post)
      expect {
        expect {
          collection.add_members([post.id, 999_999])
        }.to raise_error(ActiveRecord::RecordNotFound)
      }.not_to change { collection.posts.count }
    end
  end
end
