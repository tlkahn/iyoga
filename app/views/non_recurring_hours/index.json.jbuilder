json.array!(@non_recurring_hours) do |non_recurring_hour|
  json.extract! non_recurring_hour, :id, :instructor_id, :available_hour_start
  json.url non_recurring_hour_url(non_recurring_hour, format: :json)
end
