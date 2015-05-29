require 'test_helper'

class PostTest < ActiveSupport::TestCase

  def setup
    @topic = Topic.new(title: "Lorem Ipsum")
    @post  = Post.new(topic_id: 1, content: "Lorem Ipsum")
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "topic id should be present" do
    @post.topic_id = nil
    assert_not @post.valid?
  end

  test "content should be present" do
    @post.content = " "
    assert_not @post.valid?
  end

  test "content should be at most 50000 characters" do
    @post.content = "a" * 50001
    assert_not @post.valid?
  end
end
