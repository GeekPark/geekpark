module API::V1::Admin
  class TopicsController < AdminController
    before_action :find_topics,
                  only: %i(destroy show update add_members reset_members)

    def index
      success { paginated_with_meta Topic.all }
    end

    def show
      success { @topic }
    end

    def create
      topic = Topic.create(topic_params)
      created(topic)
    end

    def destroy
      @topic.destroy
      updated
    end

    def update
      @topic.update_attributes(topic_params)
      updated
    end

    def add_members
      @topic.add_members(params[:post_ids])
      updated
    end

    def reset_members
      @topic.reset_members(params[:post_ids])
      updated
    end

    private

    def find_topic
      @topic = Topic.find(params[:id] || params[:topic_id])
    end

    def topic_params
      params.permit(:title,
                    :description,
                    meta: Topic::DEFAULT_META.keys)
    end
  end
end
