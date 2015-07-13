class User < ActiveRecord::Base
  has_many :topics, dependent: :nullify
  has_many :posts,  dependent: :nullify
  has_many :pm_posts,  dependent: :destroy

  attr_accessor :remember_token, :activation_token, :reset_token
  before_save   :downcase_email
  before_create :create_activation_digest

  validates :email, presence:   true,
                    length:     { maximum: 255 },
                    format:     { with: Settings.email_regex },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def pm_topics
    PmTopic.where("sender_id = ? OR recipient_id = ?", id, id)
  end

  def unread_pm_topics?
    t = Settings.sql_true
    query  = "(sender_id = ? AND sender_unread = #{t}) OR "
    query += "(recipient_id = ? AND recipient_unread = #{t})"

    PmTopic.where(query, id, id).any?
  end

  private

    def downcase_email
      self.email = email.downcase
    end

    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end
