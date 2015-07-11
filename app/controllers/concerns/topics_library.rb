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
      topic = post.topic

      topic_path(topic, page: page_for(topic, post), anchor: post.anchor)
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
