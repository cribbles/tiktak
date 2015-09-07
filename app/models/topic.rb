class Topic < ActiveRecord::Base
  def self.indexed
    all.select(<<-SQL)
       topics.*,
       post.id AS post_id,
       post.content AS content,
       post.contact AS contactable
     SQL
     .joins(<<-SQL)
       INNER JOIN (
         SELECT
           posts.id, posts.content, posts.contact, posts.topic_id
         FROM posts
         ORDER BY posts.id DESC
       ) AS post ON post.topic_id = topics.id
     SQL
     .group("topics.id")
  end

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
