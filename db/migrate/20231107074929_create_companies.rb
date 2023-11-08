class CreateCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :companies do |t|
      t.string :title
      t.string :description
      t.string :registration_no
      t.date :registration_date
      t.string :legal_type

      t.timestamps
    end
  end
end
