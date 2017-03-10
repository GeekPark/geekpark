module API::V1
  class ColumnsController < APIController
    before_action :find_column, only: %i(show)

    def index
      success { paginated Column.all }
    end

    def show
      success(@column)
    end

    private

    def find_column
      @column = Column.find(params[:id] || params[:column_id])
    end
  end
end
