shared_examples :indicable_with_meta do |model, as: nil|
  it "list #{model.to_s.underscore} correctly" do
    query ||= {}
    model_name = model.to_s.underscore
    create_list(model_name, 3)

    params = { format: :json }
    params.merge!(public_send(:as, as)) if as
    get :index, params: params
    expect(response).to be_success

    expect(result).to be_a(Hash)
    expect(result['meta']).not_to be_nil

    key = model_name.pluralize
    expect(result).to have_key(key)
    expect(result[key]).to be_a(Array)
    expect(result[key].count).to be <= (query[:per]&.to_i || model.count)
  end

  if as.present? && as.intern != :visitor
    it "doesn't list #{model.to_s.underscore} without enough permission" do
      params = { format: :json }
      get :index, params: params
      expect(response).not_to be_success
    end
  end
end
