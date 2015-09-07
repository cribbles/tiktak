class Topic < ActiveRecord::Base
  def self.indexed
    all.select(<<-SQL)
       topics.*,
       posts.id AS post_id,
       posts.content AS content,
       posts.contact AS contactable,
       COUNT(posts.id) - 1 AS num_replies
     SQL
     .joins(<<-SQL)
       INNER JOIN (
         SELECT
           posts.id, posts.content, posts.contact, posts.topic_id
         FROM posts
         ORDER BY posts.id DESC
       ) AS posts ON posts.topic_id = topics.id
     SQL
     .group("topics.id")
  end

  has_many :posts, inverse_of: :topic, dependent: :destroy
  accepts_nested_attributes_for :posts
  validates :title, presence: true, length: { maximum: 140 }

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
