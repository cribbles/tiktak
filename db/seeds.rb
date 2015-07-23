# Users

User.create!(email: 'foobar@example.org',
             password:              "password",
             password_confirmation: "password",
             activated: true,
             activated_at: Time.zone.now,
             admin: true)

test_users = ['yaphet@gmail.com', 'giallo@network.com']
test_users.each do |email|
  User.create!(email: email,
               password:              "password",
               password_confirmation: "password",
               activated: true,
               activated_at: Time.zone.now)
end

# Topics

25.times do |n|
  Topic.create!(title: Faker::YikYak.words(19),
                last_posted: Time.zone.now,
                last_posted_hb: Time.zone.now)
end

Topic.all.each do |topic|
  Random.new.rand(0..25).times do |n|
    @post = Post.new(content: Faker::YikYak.words(38), topic: topic)
    @post.save
    topic.update_attributes(last_posted: @post.created_at,
                            last_posted_hb: @post.created_at)
  end
end
