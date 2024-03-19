# frozen_string_literal: true

class CreateCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.references :account, null: false, foreign_key: true
      t.references :administrator, null: false, foreign_key: { to_table: :people }
      t.string :registration_name
      t.string :registration_no, index: { unique: true }
      t.date :registration_date
      t.string :legal_type
      t.string :status, null: false, default: 'active'

      t.timestamps
    end

    create_table :company_owners do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :address
      t.string :job_title
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
