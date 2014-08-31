json.array!(@practices) do |practice|
  json.extract! practice, :id, :instructor_id, :style_id
  json.url practice_url(practice, format: :json)
end
