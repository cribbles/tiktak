class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  accepts_nested_attributes_for :posts
  validates :title, presence: true, length: { maximum: 140 }
end
