# Users

User.create!(email: "foobar@example.org",
             password:              "foobarbat",
             password_confirmation: "foobarbat",
             activated: true,
             activated_at: Time.zone.now)

# Topics

25.times do |n|
  Topic.create!(title: Faker::Lorem.sentence(3, false, 10))
end

Topic.all.each do |topic|
  25.times do |n|
    @post = Post.new(content: Faker::Lorem.sentence(18), topic: topic)
    @post.save
    topic.update_attributes(last_posted: @post.created_at)
  end
end
