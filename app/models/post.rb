class Post < ActiveRecord::Base
  include Anchorable

  belongs_to :user
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

  def index
    topic.posts.find_index(self)
  end

  def poster
    index == 0 ? 'OP' : index
  end

  def page
    index / 20 + 1
  end

  def flag
    update_attributes(flagged: true)
  end

  def unflag
    update_attributes(flagged: false)
  end

  def hellban
    update_attributes(hellbanned: true)
  end

  def remove
    update_attributes(visible: false, flagged: false)
  end
end
