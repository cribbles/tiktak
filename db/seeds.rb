100.times do |n|
  Topic.create!(title: Faker::Lorem.sentence(3, false, 10))
end
