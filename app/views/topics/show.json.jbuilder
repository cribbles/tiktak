json.topic do
  json.title @topic.title
end

json.array!(@posts) do |post|
  json.partial!(post, post: post) if displayable?(post)
end
