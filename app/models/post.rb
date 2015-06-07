class Post < ActiveRecord::Base
  belongs_to :topic, inverse_of: :posts, dependent: :destroy

  validates :topic,   presence: true
  validates :content, presence: true,
                      length: { maximum: 50000 }
end
