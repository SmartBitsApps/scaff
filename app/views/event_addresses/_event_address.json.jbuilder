json.extract! event_address, :id, :event_id, :street, :street_number, :city, :created_at, :updated_at
json.url event_address_url(event_address, format: :json)