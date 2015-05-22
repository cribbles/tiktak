require 'test_helper'

class PostTest < ActiveSupport::TestCase

  def setup
    @topic = topics(:topic_1)
    @post  = @topic.posts.build(content: "Lorem ipsum")
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
end
