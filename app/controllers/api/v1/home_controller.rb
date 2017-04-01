module API::V1
  class HomeController < APIController
    resource_description do
      short 'Homepage API for the web and apps'
    end

    api :GET, '/', 'homepage for the web'
    def web_index
      @homepage_posts = homepage_posts

      @ads = []
      @columns = []

      @hot = []
      @hearsay = Column.hearsay.new_to_old.take(10)

      success do
        variable_result(
          :ads,
          :columns,
          :hot,
          :hearsay,
          :homepage_posts
        )
      end
    end

    private

    def homepage_posts(page: 1)
      Post.homepage.new_to_old.serialized
        # .page(page).per(10)
    end
  end
end
