require 'rails_helper'

RSpec.describe API::V1::Admin::ColumnsController, type: :controller do
  it_behaves_like(:indicable, Column, as: :editor)
  it_behaves_like(:destructible, :column, as: :admin)
  it_behaves_like(:showable, :column, as: :editor)
  it_behaves_like(:creatable, Column, as: :admin) do
    let(:query) {
      Hash[
        title: FFaker::LoremCN.word,
        description: FFaker::LoremCN.words(10).join
      ]
    }
  end

  it_behaves_like(:updatable, :column, as: :admin) do
    let(:query) {
      Hash[
        title: '1',
        description: '2'
      ]
    }
  end

  describe 'add_members' do
    it 'adds members successfully' do
      n = 3
      column = create(:column)
      posts = create_list(:post, n)

      expect {
        post :add_members,
             params: {
               column_id: column.id,
               post_ids: posts.pluck(:id),
               **as(:editor),
               format: :json
             }
        expect(response).to be_no_content
      }.to change { column.posts.count }.by(n)
      expect(column.posts).to include(*posts)
    end
  end
end
