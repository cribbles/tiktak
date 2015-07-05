FactoryGirl.define do
  factory :user do
    email 'user@example.com'
    password              'password'
    password_confirmation 'password'
  end

  factory :activated_user, class: User do
    email 'user@example.com'
    password              'password'
    password_confirmation 'password'
    activated true
  end

  factory :admin_user, class: User do
    email 'user@example.com'
    password              'password'
    password_confirmation 'password'
    activated true
    admin     true
  end
end
