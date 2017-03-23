module API::V1
  class ColumnsController < APIController
    resource_description { short '專欄，每篇文章必須屬於一個專欄' }
    before_action find_record, only: %i(show)

    api :GET, '/columns', 'List all columns'
    def index
      success { paginated Column.all }
    end

    api :GET, '/columns/:id', 'Show column info and part of the members'
    def show
      success(@column)
    end
  end
end
