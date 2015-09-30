json.array!(@topics) do |topic|
  json.(topic, :id, :title, :views)
  json.num_replies pluralize(topic.num_replies, 'reply')
  json.last_posted format_date(last_posted_for topic)
  json.contactable (topic.contactable)
  json.post do
    json.id topic.posts.first.id
    json.content truncate(topic.posts.first.content, length: 256)
  end
end
