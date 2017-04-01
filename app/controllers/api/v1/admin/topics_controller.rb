module API::V1::Admin
  class TopicsController < AdminController
    resource_description { short '管理介面 專題 API' }
    before_action :find_topics,
                  only: %i(destroy show update add_members reset_members)

    api :GET, '/admin/topics', 'Get a list of all topics'
    def index
      success { paginated_with_meta Topic.all }
    end

    api :GET, '/admin/topics/:id', 'Show content for a topic'
    def show
      success { @topic }
    end

    def_param_group :topic_params do
      param :title, String, required: true
      param :description, String
    end

    api :POST, '/admin/topics', 'Create a topic'
    param_group :topic_params
    def create
      topic = Topic.create(topic_params)
      created(topic)
    end

    api :DELETE, '/admin/topics/:id', 'Destroy a topic'
    def destroy
      @topic.destroy
      updated
    end

    api :PUT, '/admin/topics/:id', 'Modify a topic'
    param_group :topic_params
    def update
      @topic.update_attributes(topic_params)
      updated
    end

    api :POST, '/admin/topics/:id/members', 'Add members to a topic'
    param :post_ids, Array,
          of: String,
          desc: 'Indicates the new members in a topic'
    def add_members
      @topic.add_members(params[:post_ids])
      updated
    end

    api :PUT, '/admin/topics/:id/members', 'Reset the members in a topic'
    param :post_ids, Array,
          of: String,
          desc: 'Indicates the replaced members in the topic'
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
