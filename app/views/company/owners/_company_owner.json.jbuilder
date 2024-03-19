json.extract! company_owner, :id, :name, :email, :phone, :address, :job_title, :company_id, :created_at, :updated_at
json.url company_owner_url(company_owner, format: :json)
