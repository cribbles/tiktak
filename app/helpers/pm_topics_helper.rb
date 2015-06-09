module PmTopicsHelper

  def handshake_offered
    pm_topic = PmTopic.find_by(id: params[:pm_topic_id])
    pm_topic.sender_handshake || pm_topic.recipient_handshake
  end
end
