json.array!(@days) do |day|
  json.extract! day, :id, :name
  json.url day_url(day, format: :json)
end
