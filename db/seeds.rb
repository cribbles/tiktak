100.times do |n|
  Topic.create!(title: Faker::Lorem.sentence(3, false, 10))
end

Topic.all.each do |topic|
  25.times do |n|
    Post.create!(content: Faker::Lorem.sentence(18), topic: topic)
  end
end
