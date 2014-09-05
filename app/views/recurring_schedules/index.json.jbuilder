json.array!(@recurring_schedules) do |recurring_schedule|
  json.extract! recurring_schedule, :id, :style_id, :level_id, :recurring_period_id, :day, :from, :to, :until
  json.url recurring_schedule_url(recurring_schedule, format: :json)
end
