require 'rails_helper'

describe API::V1::CollectionsController, type: :controller do
  let(:collections) { create_list(:collection, 3) }

  describe 'index' do
    it 'should return correct collection items' do
      collections # force

      get :index
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
        post :create, params: { **query, **as(:admin) }
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
      # get :show, params: { id: c.id }
      # expect(response).to be_success
      # expect(result).to be_a(Hash)
      # expect(result).not_to include('meta')

      get :show, params: { id: c.id, **as(:manager) }
      expect(result).to include('meta')
    end
  end
end
