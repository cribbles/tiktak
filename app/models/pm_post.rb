class PmPost < ActiveRecord::Base
  include Anchorable
  belongs_to :user
  belongs_to :pm_topic, inverse_of: :pm_posts, dependent: :destroy
  validates :pm_topic, presence: true
  validates :content,  presence: true,
                       length: { maximum: 50000 }
end
