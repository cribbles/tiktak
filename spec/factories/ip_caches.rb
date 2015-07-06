FactoryGirl.define do
  factory :ip_cache do
    ip_address '1.2.3.4'

    trait :hellbanned do
      hellbanned true
    end

    trait :blacklisted do
      blacklisted false
    end

    factory :hellbanned_ip,  traits: :hellbanned
    factory :blacklisted_ip, traits: :blacklisted
  end
end
