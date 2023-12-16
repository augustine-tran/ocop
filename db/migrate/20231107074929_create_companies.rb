class CreateCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :description
      t.string :registration_no, null: false, index: { unique: true }
      t.date :registration_date
      t.string :legal_type
      t.string :status, null: false, default: 'active'
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
