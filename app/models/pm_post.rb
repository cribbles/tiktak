class PmPost < ActiveRecord::Base
  belongs_to :pm_topic
  belongs_to :user
end
