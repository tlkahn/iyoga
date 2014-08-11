json.array!(@instructors) do |instructor|
  json.extract! instructor, :id, :user_id, :address, :certificates, :teach_since, :style
  json.url instructor_url(instructor, format: :json)
end
