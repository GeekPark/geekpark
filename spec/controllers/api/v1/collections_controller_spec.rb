require 'rails_helper'

describe API::V1::CollectionsController, type: :controller do
  let(:collections) { create_list(:collection, 3) }

  describe 'index' do
    it 'should return correct collection items' do
      collections # force

      get :index, params: as(:editor)
      expect(response).to be_success
      expect(result).to be_an(Array)
      expect(result).to have(3).items

      expected_titles = result.map { |x| x['title'] }
      actual_titles = collections.pluck(:title)
      expect(expected_titles).to match_array(actual_titles)
    end
  end

  describe 'create' do
    it 'should create collection successfully' do
      query = {
        title: FFaker::LoremCN.words(2).join,
        description: FFaker::LoremCN.words(2).join
      }

      expect {
        post :create, format: :json, params: { **query, **as(:admin) }
        expect(response).to be_success
      }.to change { Collection.count }.by(1)

      expect(result).to be_an(Hash)

      id = result['id']
      expect(id).to be_an(Integer)

      collection = Collection.find(id)
      expect(collection).to be_present
      expect(collection.attributes.symbolize_keys).to include(query)
    end
  end

  describe 'destroy' do
    it 'should destroy collection successfully' do
      c = collections.first
      expect {
        delete :destroy, params: { id: c.id, **as(:admin) }
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

  describe 'update' do
    it 'update collection correctly' do
      c = collections.first
      record = {
        id: c.id,
        title: '1',
        description: '2',
        banner: '3',
        banner_mobile: '4',
        meta: { 'paginate_per' => '100' }
      }
      put :update, params: { **record, **as(:admin), format: :json }

      expect(response).to be_no_content
      c.reload

      record.each do |key, val|
        if val.is_a? Hash
          expect(c[key]).to include(val)
        else
          expect(c[key]).to eq(val)
        end
      end
    end
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
