class PmTopic < ActiveRecord::Base
  belongs_to :sender,    class_name: "User"
  belongs_to :recipient, class_name: "User"
  has_many :pm_posts, inverse_of: :pm_topic, dependent: :destroy
  accepts_nested_attributes_for :pm_posts

  def title
    'Re: ' + Topic.find_by(id: self.topic_id).title
  end
end
