require 'rails_helper'
# require_relative '../../app/helpers/api_controller_helper'

describe APIControllerHelper do
  describe :paginated do
    it 'paginate a collection' do
      create_list(:post, 20)
      posts = Post.all

      expect(paginated(posts).total_pages).to eq(2)
      expect(paginated(posts, 3).total_pages).to eq(7)
      expect(paginated(posts, 5).count).to eq(5)
      expect(paginated(posts, 5).count).to eq(5)
      expect(paginated(posts).total_count).to eq(20)
      expect(paginated { posts }.total_count).to eq(20)
    end

    it 'correctly paginate with meta info' do
      create_list(:post, 20)
      posts = Post.all

      paginated = paginated_with_meta(posts, 3)
      paginated = paginated[:__extra_opts]

      expect(paginated[:json].count).to eq(3)
      expect(paginated[:meta][:current_page]).to eq(1)
      expect(paginated[:meta][:total_pages]).to eq(7)
      expect(paginated[:meta][:total_count]).to eq(20)
    end
  end
end
