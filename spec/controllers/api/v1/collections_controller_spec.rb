require 'rails_helper'

describe API::V1::CollectionsController, type: :controller do
  let(:collections) { create_list(:collection, 3) }

  it_behaves_like(:indicable, Collection)
  it_behaves_like(:creatable, Collection, as: :editor) do
    let(:query) {
      Hash[
        title: FFaker::LoremCN.words(2).join,
        description: FFaker::LoremCN.words(2).join
      ]
    }
  end

  describe 'destroy' do
    it 'should destroy collection successfully' do
      c = collections.first
      expect {
        delete :destroy, params: { id: c.id, **as(:editor) }
        expect(response).to be_success
      }.to change { Collection.count }.by(-1)
    end

    it 'should not destroy collection' do
      c = collections.first
      expect {
        delete :destroy, params: { id: c.id }
        expect(response).not_to be_success

        expect {
          delete :destroy, params: { id: c.id + 999, **as(:admin) }
        }.to raise_error(ActiveRecord::RecordNotFound)
      }.to change { Collection.count }.by(0)
    end
  end

  describe 'show' do
    it 'show collection correctly' do
      c = collections.first
      get :show, params: { id: c.id }
      expect(response).to be_success
      expect(result).to be_a(Hash)
      expect(result).not_to include('meta')
    end

    it 'show collection correctly for managers' do
      c = collections.first
      get :show, params: { id: c.id, **as(:admin) }
      expect(result).to include('meta')
    end
  end

  it_behaves_like(:updatable, :collection, as: :admin) do
    let(:query) {
      Hash[
        title: '1',
        description: '2',
        banner: '3',
        banner_mobile: '4',
        meta: { 'paginate_per' => '100' }
      ]
    }
  end

  describe 'add_members' do
    it 'add members correctly' do
      n = 3
      c = create(:collection, :with_topics)
      topics = create_list(:topic, n)

      expect {
        post :add_members,
             params: {
               collection_id: c.id,
               topic_ids: topics.pluck(:id),
               **as(:editor),
               format: :json
             }
      }.to change { c.topics.count }.by(n)
      expect(c.topics.pluck(:id)).to include(*topics.pluck(:id))
    end
  end

  describe 'reset_members' do
    it 'reset members correctly' do
      n = 4
      c = create(:collection, :with_topics)
      topics = create_list(:topic, n)

      expect {
        post :reset_members,
             params: {
               collection_id: c.id,
               topic_ids: topics.pluck(:id),
               **as(:editor),
               format: :json
             }
      }.to change { c.topics.count }.to(n)
      expect(c.topics.pluck(:id)).to match_array(topics.pluck(:id))
    end
  end
end
