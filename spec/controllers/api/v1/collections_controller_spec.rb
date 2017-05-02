require 'rails_helper'

describe API::V1::CollectionsController, type: :controller do
  let(:collections) { create_list(:collection, 3) }

  it_behaves_like(:indicable, Collection, as: :editor)

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
    end
  end
end
