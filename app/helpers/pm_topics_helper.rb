module PmTopicsHelper

  def correspondent_for(pm_topic)
    return "Anonymous" unless handshake_accepted?(pm_topic)
    if pm_topic.sender_id == current_user.id
      correspondent_id = pm_topic.recipient_id
    elsif pm_topic.recipient_id == current_user.id
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

  def unread?(pm_topic)
    sender    = pm_topic.sender_id    == current_user.id
    recipient = pm_topic.recipient_id == current_user.id
    (sender && pm_topic.sender_unread) || (recipient && pm_topic.recipient_unread)
  end
end
