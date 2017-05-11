require 'rails_helper'

describe Countable do
  before(:all) do
    FactoryGirl.create(:post)
    @post = Post.last
  end

  it "should has_many action_counts" do
    expect(Post.new).to have_many(:click_counts).class_name('Count')
      .dependent(:destroy)
      .inverse_of(:countable)
  end

  it "should define incr_action_count correctly" do
    expect { @post.incr_click_count }.to change{@post.click_counts.count}.by(1)
    expect(@post.click_counts.first.countable).to eq(@post)
  end

  it "should define order_by_action_count correctly" do
    first = Post.first.incr_click_count(2)
    last = Post.last.incr_click_count(1)
    result = [Post.first,Post.last]
    expect(Post.order_by_click_count).to eq(result)
  end

  it "should define count_actions correctly" do
    Post.first.incr_click_count(2)
    expect(Post.count_clicks).to eq(2)
  end
end
