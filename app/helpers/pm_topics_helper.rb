module PmTopicsHelper

  def correspondent(pm_topic)
    return 'Anonymous' unless handshake_accepted?(pm_topic)

    User.find_by(id: correspondent_id(pm_topic)).email
  end

  def handshake_sent?(pm_topic)
    pm_topic.sender_handshake || pm_topic.recipient_handshake
  end

  def handshake_accepted?(pm_topic)
    pm_topic.sender_handshake && pm_topic.recipient_handshake
  end

  def handshake_in_progress?(pm_topic)
    handshake_sent?(pm_topic) &&
      !pm_topic.handshake_declined &&
      !handshake_accepted?(pm_topic)
  end

  def unread_class?(pm_topic)
    # determines whether to stylize links for unread pm topics

    unread?(pm_topic) ? 'unread' : nil
  end

  private

  def correspondent_id(pm_topic)
    case current_user.id
    when pm_topic.sender_id then pm_topic.recipient_id
    when pm_topic.recipient_id then pm_topic.sender_id
    end
  end

  def unread?(pm_topic)
    sender    = pm_topic.sender_id    == current_user.id
    recipient = pm_topic.recipient_id == current_user.id

    (sender && pm_topic.sender_unread) ||
      (recipient && pm_topic.recipient_unread)
end
end
