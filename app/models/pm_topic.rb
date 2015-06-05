class PmTopic < ActiveRecord::Base
  has_one :user_1
  has_one :user_2
  has_many :pm_posts, inverse_of: :pm_topic, dependent: :destroy
  accepts_nested_attributes_for :pm_posts
  validates :title, presence: true, length: { maximum: 140 }
end
