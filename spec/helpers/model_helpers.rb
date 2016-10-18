module ModelHelper
  def match_query(object, query)
    query.deep_stringify_keys.each do |key, val|
      case val
      when Hash
        expect(object[key]).to include(val)
      else
        expect(object[key]).to eq(val)
      end
    end
  end
end
