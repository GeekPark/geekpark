require 'rails_helper'

RSpec.describe API::V1::CommentsController, type: :controller do
  describe 'index' do
    let!(:post) { create(:post) }
    let!(:comment) { create(:comment, commentable: post) }

    it 'list comments correctly' do
      get :index, params: { post_id: post.id }
      expect(response).to be_success
      expect(result).to have_key('comments')
      expect(result['comments']).to be_an(Array)
      expect(result['comments'].first['id']).to eq(comment.id)
    end

    it 'list nothing for post without comment' do
      post_ = create(:post)

      get :index, params: { post_id: post_.id }
      expect(response).to be_success
      expect(result).to have_key('comments')
      expect(result['comments']).to be_an(Array)
      expect(result['comments']).to be_empty
    end
  end

  describe 'create' do
    let!(:post_) { create(:post) }

    it 'creates comment correctly' do
      expect {
        post :create, params: {
               post_id: post_.id,
               content: 'allahu akbar'
             }
        expect(response).to be_success
      }.to change { Comment.count }.by(1)
    end

    it 'refers to the parent comment' do
      parent = create(:comment, commentable: post_)
      expect {
        post :create, params: {
               post_id: post_.id,
               content: 'allahu akbar',
               parent_id: parent.id
             }
        expect(response).to be_success
      }.to change { Comment.count }.by(1) &
           change { parent.children.count }.by(1)
    end
  end
end
