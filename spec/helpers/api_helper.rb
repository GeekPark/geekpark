module APIHelper
  def result
    @result ||= JSON.parse(response.body)
  end

  def symbolic_result
    @symbolic_result ||= result.deep_symbolize_keys
  end
end
