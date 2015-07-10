module TopicsHelper

  def last_posted_for(topic)
    hellbanned? ? topic.last_posted_hb : topic.last_posted
  end
end
