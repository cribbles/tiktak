FactoryGirl.define do
  factory :user do
    email 'user@example.com'
    password              'password'
    password_confirmation 'password'
 
    trait :admin do
      admin true
    end
    
    trait :activated do
      activated true
    end

    trait :inactivated do
      activated false
    end

    factory :admin_user,       traits: [:admin, :activated]
    factory :activated_user,   traits: :activated
    factory :inactivated_user, traits: :inactivated
  end
end
