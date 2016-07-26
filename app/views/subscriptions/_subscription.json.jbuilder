json.extract! subscription, :id, :brigade_id, :user_id, :approved, :created_at, :updated_at
json.url subscription_url(subscription, format: :json)