json.array!(@recurring_schedule_exceptions) do |recurring_schedule_exception|
  json.extract! recurring_schedule_exception, :id, :recurring_schedule_id, :day
  json.url recurring_schedule_exception_url(recurring_schedule_exception, format: :json)
end
