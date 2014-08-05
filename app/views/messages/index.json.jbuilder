json.array!(@messages) do |message|
  json.extract! message, :id, :from_user_id, :to_user_id, :title, :body
  json.url message_url(message, format: :json)
end
