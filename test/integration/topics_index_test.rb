require 'test_helper'

class TopicsIndexTest < ActionDispatch::IntegrationTest

  test "index including pagination" do
    get topics_path
    assert_template 'topics/index'
    assert_select 'div.pagination'
    first_page_of_topics = Topic.paginate(page: 1)
    first_page_of_topics.each do |topic|
      assert_select 'a[href=?]', topic_path(topic), text: topic.title
    end
  end
end
