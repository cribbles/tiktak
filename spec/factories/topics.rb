FactoryGirl.define do
  factory :topic do
    title          'First topic'
    last_posted    Time.zone.now
    last_posted_hb Time.zone.now

    trait :hellbanned do
      hellbanned true
    end

    trait :invisible do
      visible false
    end

    trait :with_user do
      user { |u| u.association(:user) }
    end

    factory :hellbanned_topic, traits: :hellbanned
    factory :invisible_topic,  traits: :invisible
    factory :user_topic,       traits: :with_user
  end
end
