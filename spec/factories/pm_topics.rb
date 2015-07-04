FactoryGirl.define do
  factory :pm_topic do
    title       'Hello!'
    last_posted Time.zone.now
  end
end
