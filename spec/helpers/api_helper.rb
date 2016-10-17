module APIHelper
  def result
    @result ||= JSON.parse(response.body)
  end
end
