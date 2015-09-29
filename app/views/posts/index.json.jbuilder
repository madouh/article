json.array!(@posts) do |post|
  json.extract! post, :id, :name, :comment
  json.url post_url(post, format: :json)
end
