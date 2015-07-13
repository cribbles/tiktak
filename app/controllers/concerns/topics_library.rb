module TopicsLibrary
  extend ActiveSupport::Concern

  included do
    helper_method :topic_path_for
  end

  private

    def ensure_topic_exists
      redirect_to root_url unless topic
    end

    def displayable(where: nil)
      where ||= {}
      where.merge!(visible: true)
      where.merge!(hellbanned: false) unless hellbanned?

      where
    end

    def topic_path_for(post)
      topic_path(post.topic, page: post.page, anchor: post.anchor)
    end
end
