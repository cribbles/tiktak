module RoutesHelper

  def topics_show?
    return false unless defined? @topic.id
    current_page?(topic_path(@topic))
  end

  def posts_new?
    return false unless defined? @topic.id
    if defined? @quote.id
      current_page?(quote_path(@topic, @quote))
    else
      current_page?(new_topic_post_path(@topic))
    end
  end
end
