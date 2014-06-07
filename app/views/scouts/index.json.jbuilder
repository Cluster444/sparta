json.array!(@scouts) do |scout|
  json.extract! scout, :id
  json.url scout_url(scout, format: :json)
end
