module API::V1
  class HomeController < APIController
    def web_index
      @homepage_posts = Post.homepage.new_to_old.per(10)

      @ads = []
      @columns = []

      @hot = []
      @hearsay = Column.hearsay.new_to_old.per(10)

      variable_result(
        :ads,
        :columns,
        :hot,
        :hearsay,
        :homepage_posts
      )
    end
  end
end
