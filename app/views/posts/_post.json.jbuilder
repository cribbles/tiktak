if displayable?(post)
  json.(post, :id, :poster, :content)
  json.posted format_date(post.updated_at)
  json.contactable post.contact

  if has_displayable_quote?(post)
    json.quote do
      quote = post.quoted
      json.id quote.id
      json.content truncate(quote.content, length: 256)
    end
  end
end
