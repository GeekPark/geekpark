shared_examples :destructible do |factory, as: nil|
  it "destroy #{factory} correctly" do
    create_list(factory, 3)
    object = create(factory)

    params = { format: :json, id: object.id }
    params.merge!(public_send(:as, as)) if as

    expect {
      delete :destroy, params: params
      expect(response).to be_no_content
    }.to change { object.class.count }.by(-1)
  end

  if as.present? && as.intern != :visitor
    it "doesn't destroy #{factory} without enough permission" do
      object = create(factory)
      params = { format: :json, id: object.id }

      expect {
        delete :destroy, params: params
        expect(response).not_to be_success
      }.not_to change { object.class.count }
    end
  end
end
