module PmLibrary
  extend ActiveSupport::Concern

  included do
    before_action :ensure_logged_in
  end

  private

  def ensure_pm_topic_exists
    redirect_to root_url if pm_topic.nil?
  end

  def ensure_valid_user
    redirect_to root_url unless pm_topic.users.include?(current_user)
  end

  def user
    current_user == pm_topic.sender ? 'sender' : 'recipient'
  end

  def correspondent
    user == 'sender' ? 'recipient' : 'sender'
  end

  def user_handshake
    "#{user}_handshake".to_sym
  end

  def user_unread
    "#{user}_unread".to_sym
  end

  def correspondent_unread
    "#{correspondent}_unread".to_sym
  end
end
