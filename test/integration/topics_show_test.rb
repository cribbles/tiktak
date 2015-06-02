require 'test_helper'

class TopicsShowTest < ActionDispatch::IntegrationTest

  def setup
    @topic = topics(:topic_1)
  end

  test "topic display including pagination" do
    get topic_path(@topic)
    assert_template 'topics/show'
    assert_select 'div.pagination'
    posts = @topic.posts.paginate(page: 1, per_page: 20)
    posts.each_with_index do |post,index|
      who_posted = (index == 0) ? 'OP' : index
      assert_select 'tr.cell3'
      assert_select 'div.poster'
      assert_select who_posted, response.body
      assert_select 'a[href=?]', quote_path(@topic, post), text: 'Quote'
      assert_select 'tr.cell4'
      assert_select 'p.post2'
      assert_match  post.content, response.body
    end
  end
end
