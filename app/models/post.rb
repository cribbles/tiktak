class Post < ActiveRecord::Base
  belongs_to :topic
  validates :topic_id, presence: true
  validates :content,  presence: true
end
