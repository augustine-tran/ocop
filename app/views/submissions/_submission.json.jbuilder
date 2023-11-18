json.extract! submission, :id, :title, :submission_type, :created_at, :updated_at
json.url submission_url(submission, format: :json)
