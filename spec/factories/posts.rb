FactoryGirl.define do
  factory :post do
    content    'This is a test post!'
    ip_address '1.2.3.4'
    topic { |p| p.association(:topic) }

    trait :hellbanned do
      hellbanned true
    end

    trait :invisible do
      visible false
    end

    trait :contactable do
      contact true
    end

    trait :with_user do
      user { |u| u.association(:user) }
    end

    factory :hellbanned_post, traits: :hellbanned
    factory :invisible_post,  traits: :invisible
    factory :user_post,       traits: :with_user
  end
end
