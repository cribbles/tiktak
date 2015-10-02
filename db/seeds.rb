# Users

User.create!(email: 'user@example.org',
             password: "password",
             password_confirmation: "password",
             activated: true,
             activated_at: Time.zone.now,
             admin: true)

test_users = ['yaphet@gmail.com', 'giallo@network.com']
test_users.each do |email|
  User.create!(email: email,
               password: "password",
               password_confirmation: "password",
               activated: true,
               activated_at: Time.zone.now)
end

# Topics

25.times do |n|
  Topic.create!(title: Faker::YikYak.words(13),
                last_posted: Time.zone.now,
                last_posted_hb: Time.zone.now)
end

Topic.all.each do |topic|
  Random.new.rand(1..25).times do |n|
    num_words = Random.new.rand(38..52)
    @post = Post.new(content: Faker::YikYak.words(num_words), topic: topic)
    @post.save
    topic.update_attributes(last_posted: @post.created_at,
                            last_posted_hb: @post.created_at)
  end
end
