require 'test_helper'

class TopicsIndexTest < ActionDispatch::IntegrationTest

  test "index including pagination" do
    get topics_path
    assert_template 'topics/index'
    assert_select 'div.pagination'
    first_page_of_topics = Topic.order(last_posted: :desc)
                                .paginate(page: 1, per_page: 20)
    first_page_of_topics.each do |topic|
      assert_select 'a[href=?]', topic_path(topic), text: topic.title
      assert_match topic.posts.first.content, response.body
    end
  end
end
