require 'test_helper'

class TopicTest < ActiveSupport::TestCase

  def setup
    @topic = Topic.new(title: "Lorem ipsum")
  end

  test "should be valid" do
    assert @topic.valid?
  end

  test "title should be at most 140 characters" do
    @topic.title = "a" * 141
    assert_not @topic.valid?
  end
end
