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

  def path_for(post)
    topic = Topic.find_by(id: post.topic_id)
    topic_path(topic, page: page_for(topic, post),
                      anchor: anchor_for(post)) 
  end

  def delete_link_for(topic, post = nil)
    if post && post != topic.posts.first
      path = post
      msg = 'Really remove this post?'
    else
      path = topic
      msg = 'This action will remove the entire topic. Are you sure?'
    end
    link_to 'X', path, class: 'crimson', method: :delete, data: { confirm: msg }
  end

  private

    def anchor_for(post)
      "p" + post.id.to_s
    end

    def page_for(topic, post)
      page = 1
      posts = topic.posts.inject([]) {|acc,p| acc << p.id}
      post_index = posts.index(post.id.to_i)
      until post_index < 20
        post_index -= 20
        page += 1
      end
      page
    end
end
