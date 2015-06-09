module PmPostsHelper

  def who_posted(pm_post)
    current_user.id == pm_post.user_id ? "You" : "Anonymous"
  end
end
