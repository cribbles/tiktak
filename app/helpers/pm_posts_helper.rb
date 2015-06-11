module PmPostsHelper

  def who_posted(pm_post)
    return "You" if current_user.id == pm_post.user_id
    pm_topic = PmTopic.find_by(id: pm_post.pm_topic_id)
    other_user = User.find_by(id: pm_post.user_id)
    handshake_accepted?(pm_topic) ? other_user.email : "Anonymous"
  end
end
