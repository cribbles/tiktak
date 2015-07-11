module TopicsLibrary
  extend ActiveSupport::Concern

  included do
    before_action :ensure_admin, only: :destroy
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
end
