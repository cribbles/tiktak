module PmTopicsHelper

  def correspondent_for(pm_topic)
    return "Anonymous" unless handshake_accepted?(pm_topic)
    case current_user.id
    when pm_topic.sender_id
      correspondent_id = pm_topic.recipient_id
    when pm_topic.recipient_id
      correspondent_id = pm_topic.sender_id
    end
    User.find_by(id: correspondent_id).email
  end

  def handshake_sent?(pm_topic)
    pm_topic.sender_handshake || pm_topic.recipient_handshake
  end

  def handshake_accepted?(pm_topic)
    pm_topic.sender_handshake && pm_topic.recipient_handshake
  end

  def handshake_in_progress?(pm_topic)
    handshake_sent?(pm_topic) && !pm_topic.handshake_declined && !handshake_accepted?(pm_topic)
  end
end
