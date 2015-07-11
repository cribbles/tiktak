class Post < ActiveRecord::Base
  belongs_to :topic, inverse_of: :posts, dependent: :destroy

  validates :topic,   presence: true
  validates :content, presence: true,
                      length: { maximum: 50000 }

  def visible?
    self.visible && !self.hellbanned
  end

  def quoted
    if self.quote && Post.find_by(id: self.quote).visible
      Post.find_by(id: self.quote)
    end
  end

  def user
    User.find_by(id: self.user_id)
  end
end
