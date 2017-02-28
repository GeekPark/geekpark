shared_examples :indicable do |model, as: nil|
  it "list #{model.to_s.underscore} correctly" do
    query ||= {}
    create_list(model.to_s.underscore, 3)

    params = { format: :json }
    params.merge!(public_send(:as, as)) if as
    get :index, params: params
    expect(response).to be_success

    expect(result).to be_an(Array)
    expect(result.count).to be <= (query[:per]&.to_i || model.count)
  end

  if as.present? && as.intern != :visitor
    it "doesn't list #{model.to_s.underscore} without enough permission" do
      params = { format: :json }
      get :index, params: params
      expect(response).not_to be_success
    end
  end
end
