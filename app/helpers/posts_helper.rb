module PostsHelper

  def poster_for(post, page)
    page   ||= 1
    @count ||= 0
    if @count < 1 and page.to_i < 2
      @count += 1
      return 'OP'
    else
      post_number = (page.to_i - 1) * 20 + @count
      @count += 1
    end
    post_number
  end

  def displayable?(post)
    post.visible? || (hellbanned? && post.hellbanned)
  end

  def delete_link_for(topic, post = nil)
    if post && post != topic.posts.first
      path = topic_post_path(topic, post)
      msg = 'Really remove this post?'
    else
      path = topic
      msg = 'This action will remove the entire topic. Are you sure?'
    end
    link_to 'X', path, class: 'delete', method: :delete, data: { confirm: msg }
  end
end
