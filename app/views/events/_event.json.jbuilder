json.extract! event, :id, :user_id, :title, :description, :start_date, :end_date, :manager, :visible, :created_at, :updated_at
json.url event_url(event, format: :json)