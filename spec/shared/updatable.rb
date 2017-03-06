shared_examples :updatable do |factory, as: nil|
  model_name = factory.to_s.underscore

  it "update #{model_name} correctly" do
    object = create(factory)

    params = { format: :json, **query, id: object.id }
    params.merge!(public_send(:as, as)) if as

    put :update, params: params
    expect(response).to be_no_content

    object.reload
    object_props ||= query
    match_query(object, object_props)
  end

  if as.present? && as.intern != :visitor
    it "doesn't update #{model_name} without enough permission" do
      object = create(factory)

      params = { format: :json, **query, id: object.id }

      put :update, params: params
      expect(response).not_to be_success
    end
  end
end
