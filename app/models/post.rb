class Post < ActiveRecord::Base
  belongs_to :topic, inverse_of: :posts, dependent: :destroy

  validates :topic,   presence: true
  validates :content, presence: true,
                      length: { maximum: 50000 }

  def visible?
    self.visible && !self.hellbanned
  end

  def quoted
    Post.find_by(id: self.quote)
  end

  def user
    User.find_by(id: self.user_id)
  end

  def flag
    update_attributes(flagged: true)
  end

  def unflag
    update_attributes(flagged: false)
  end

  def remove
    update_attributes(visible: false, flagged: false)
  end
end
