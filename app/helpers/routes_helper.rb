module RoutesHelper

  def topics_show?
    return false unless defined? @topic.id
    return false if @topic.id.nil?
    current_page?(topic_path(@topic))
  end

  def posts_new?
    return false unless defined? @topic.id
    return false if @topic.id.nil?
    if defined? @quote.id
      current_page?(quote_path(@topic, @quote))
    else
      current_page?(new_topic_post_path(@topic))
    end
  end

  def pm_topics_show?
    return false unless defined? @pm_topic.id
    return false if @pm_topic.id.nil?
    current_page?(pm_topic_path(@pm_topic))
  end
end
