class Topic < ActiveRecord::Base
  has_many :posts, inverse_of: :topic, dependent: :destroy
  accepts_nested_attributes_for :posts
  validates :title, presence: true, length: { maximum: 140 }

  def num_replies
    posts.count - 1
  end

  def increment_views
    update_attributes(views: views + 1)
  end

  def hellban
    update_attributes(hellbanned: true)
  end

  def remove
    posts.each(&:remove)

    update_attributes(visible: false)
  end
end
