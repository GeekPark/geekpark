module StructuredCache
  def cache_json(key, *args, **kwargs)
    json = Rails.cache.fetch(key, *args, **kwargs) { JSON.dump(yield) }
    JSON.parse(json)
  end
end
