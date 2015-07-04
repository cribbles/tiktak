FactoryGirl.define do
  factory :pm_post do
    content 'This is a test message!'
    ip_address '1.2.3.4'
    user     { |p| p.association(:user) }
    pm_topic { |p| p.association(:pm_topic) }
  end
end
