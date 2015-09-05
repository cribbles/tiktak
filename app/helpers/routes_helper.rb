module RoutesHelper

  def topics_show?
    return false if !defined?(@topic.id) || @topic.id.nil?

    current_page?(topic_path(@topic))
  end

  def topics_index?
    current_page?(root_path) || current_page?(topics_path)
  end

  def posts_new?
    return false if !defined?(@topic.id) || @topic.id.nil?

    if defined?(@quote.id)
      current_page?(quote_path(@topic, @quote))
    else
      current_page?(new_topic_post_path(@topic))
    end
  end

  def pm_topics_show?
    return false if !defined?(@pm_topic.id) || @pm_topic.id.nil?

    current_page?(pm_topic_path(@pm_topic))
  end
end
