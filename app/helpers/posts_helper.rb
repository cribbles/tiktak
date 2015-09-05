module PostsHelper

  def displayable?(post)
    post.visible? || (hellbanned? && post.hellbanned)
  end

  def has_displayable_quote?(post)
    post.quoted && displayable?(post.quoted)
  end

  def anchor_tag(post)
    content_tag :a, nil, name: post.anchor
  end

  def quote_link_for(post)
    link_to 'Quote', quote_path(post.topic, post)
  end

  def contact_link_for(topic, post: nil)
    contact = 'contact'
    contact.capitalize! if post
    post ||= topic.posts.first

    link_to contact,
      new_pm_topic_path(topic, post),
      class: 'contact'
  end

  def report_link_for(topic, post: nil)
    row = post ? 'post' : 'topic'
    post ||= topic.posts.first

    link_to 'Report',
      topic_post_path(topic, post),
      method: :patch,
      data: { confirm: "Flag this #{row} for moderation?" }
  end

  def delete_link_for(topic, post: nil)
    if post && post != topic.posts.first
      path = topic_post_path(topic, post)
      msg = 'Really remove this post?'
    else
      path = topic
      msg = 'This action will remove the entire topic. Are you sure?'
    end

    link_to 'X',
      path,
      method: :delete,
      data: { confirm: msg },
      class: 'delete'
  end

  def context_link_for(post)
    link_to 'Context', topic_path_for(post)
  end

  def unflag_link_for(post)
    link_to 'Unflag',
      dismiss_path(post),
      method: :patch,
      class: 'dismiss'
  end
end
