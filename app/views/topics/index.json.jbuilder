json.array!(@topics) do |topic|
  json.(topic, :id, :title)
  json.num_replies pluralize(topic.num_replies, 'reply')
  json.contactable topic.contactable?
  json.last_posted format_date(last_posted_for topic)
  json.post do
    post = topic.posts.first
    json.id post.id
    json.content truncate(post.content, length: 256)
  end
end
