class Topic < ActiveRecord::Base
  has_many :posts, inverse_of: :topic, dependent: :destroy
  accepts_nested_attributes_for :posts
  validates :title, presence: true, length: { maximum: 140 }

  def contactable?
    posts.first.contact
  end

  def post_id
    posts.first.id
  end

  def content
    posts.first.content
  end

  def replies
    posts.count-1
  end
end
