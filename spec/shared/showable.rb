shared_examples :showable do |factory, as: nil|
  it "show #{factory} correctly" do
    object = create(factory)

    params = { format: :json, id: object.id }
    params.merge!(public_send(:as, as)) if as

    get :show, params: params
    expect(response).to be_success

    expect(result).to have_key(factory.to_s)
    expect(result[factory.to_s]['id']).to eq(object.id)
  end
end
