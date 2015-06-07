class PmTopic < ActiveRecord::Base
  has_one :sender
  has_one :recipient
  belongs_to :sender,    class_name: "User"
  belongs_to :recipient, class_name: "User"
  has_many :pm_posts, inverse_of: :pm_topic, dependent: :destroy
  accepts_nested_attributes_for :pm_posts

  validates_associated :sender
  validates_associated :recipient
end
