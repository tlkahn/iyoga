json.array!(@certificates) do |certificate|
  json.extract! certificate, :id, :title, :institute_id
  json.url certificate_url(certificate, format: :json)
end
