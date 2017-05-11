require 'rails_helper'

describe Countable do

	before(:each) do
		class Post < ActiveRecord::Base
			include Countable
			add_instance_counter_for :click
		end

		@post = Post.new
	end

	it "should has_many action_counts" do
    expect(Post.new).to have_many(:click_counts).class_name('Count')
                                                .dependent(:destroy)
                                                .inverse_of(:countable)
	end

	it "should define incr_action_count correctly" do
		count = @post.incr_click_count
		expect(count.count).to eq(1)
		expect(count.countable).to eq(@post)
	end

end