json.array!(@credentials) do |credential|
  json.extract! credential, :id, :instructor_id, :certificate_id
  json.url credential_url(credential, format: :json)
end
