require 'test_helper'

class TopicTest < ActiveSupport::TestCase

  def setup
    @topic = Topic.new(title: "Lorem ipsum")
  end

  test "should be valid" do
    assert @topic.valid?
  end
end
