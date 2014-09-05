json.array!(@recurring_periods) do |recurring_period|
  json.extract! recurring_period, :id, :name
  json.url recurring_period_url(recurring_period, format: :json)
end
