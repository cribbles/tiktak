json.array!(@topics) do |topic|
  json.(topic, :id, :title, :views)
  json.num_replies pluralize(topic.num_replies, 'reply')
  json.last_posted format_date(last_posted_for topic)
  json.contactable (topic.contactable != "f")
  json.post do
    json.id topic.post_id
    json.content truncate(topic.content, length: 256)
  end
end
