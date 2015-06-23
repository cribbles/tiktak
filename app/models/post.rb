class Post < ActiveRecord::Base
  belongs_to :topic, inverse_of: :posts, dependent: :destroy

  validates :topic,   presence: true
  validates :content, presence: true,
                      length: { maximum: 50000 }

  def has_quote?
    self.quote && Post.find_by(id: self.quote).visible
  end
end
