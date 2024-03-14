# frozen_string_literal: true

class CreateSubmissions < ActiveRecord::Migration[7.1]
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.references :account, null: false, foreign_key: true
      t.references :owner, null: false, foreign_key: { to_table: :people }
      t.string :registration_name
      t.string :registration_no, index: { unique: true }
      t.date :registration_date
      t.string :legal_type
      t.string :status, null: false, default: 'active'

      t.timestamps
    end

    create_table :submissions do |t|
      t.string :name, null: false
      t.references :council, null: false, foreign_key: true
      t.references :criteria_group, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.string :description
      t.string :status, null: false, default: :drafted
      t.numeric :scores_sum, null: false, default: 0
      t.integer :star, null: false, default: 0
      t.references :creator, foreign_key: { to_table: :people }
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
