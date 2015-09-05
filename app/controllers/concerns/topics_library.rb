module TopicsLibrary
  extend ActiveSupport::Concern

  included do
    helper_method :topic_path_for
  end

  private

  def ensure_topic_exists
    redirect_to root_url if topic.nil?
  end

  def displayable(where: {})
    where.merge!(hellbanned: false) unless hellbanned?
    where.merge!(visible: true)
  end

  def topic_path_for(post)
    topic_path(post.topic, page: post.page, anchor: post.anchor)
  end
end
