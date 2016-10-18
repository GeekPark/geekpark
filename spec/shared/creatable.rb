shared_examples :creatable do |model, as: nil|
  it "creates #{model.to_s.underscore} correctlly" do
    expect {
      params = { **query, format: :json }
      params.merge!(public_send(:as, as)) if as
      post :create, params: params
      expect(response).to be_success
    }.to change { model.count }.by(1)

    expect(result).to be_an(Hash)

    id = result['id']
    expect(id).to be_an(Integer)

    object = model.find(id)
    expect(object).to be_present
    match_query(object, query)
    # expect(object.attributes.symbolize_keys).to include(query)
  end

  if as.present? && as.intern != :visitor
    it "doesn't create #{model.to_s.underscore} without enough permission" do
      expect {
        params = { **query, format: :json }
        post :create, params: params
        expect(response).not_to be_success
      }.not_to change { model.count }
    end
  end
end
