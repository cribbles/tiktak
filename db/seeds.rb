# Users

test_users = ['foobar@example.org', 'yaphet@gmail.com', 'giallo@network.com']
test_users.each do |email|
  User.create!(email: email,
               password:              "password",
               password_confirmation: "password",
               activated: true,
               activated_at: Time.zone.now)
end

# Topics

25.times do |n|
  Topic.create!(title: Faker::Lorem.sentence(3, false, 10),
                last_posted: Time.zone.now)
end

Topic.all.each do |topic|
  25.times do |n|
    @post = Post.new(content: Faker::Lorem.sentence(18), topic: topic)
    @post.save
    topic.update_attributes(last_posted: @post.created_at)
  end
end
