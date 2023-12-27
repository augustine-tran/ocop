class CreateCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :description
      t.boolean :is_primary, null: false, default: false
      t.string :registration_name
      t.string :registration_no, index: { unique: true }
      t.date :registration_date
      t.string :legal_type
      t.string :status, null: false, default: 'active'
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
