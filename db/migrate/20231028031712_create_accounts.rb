# frozen_string_literal: true

class CreateAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :administrative_units do |t|
      t.string :name
      t.string :code
      t.string :level

      t.timestamps
    end

    create_table :addresses do |t|
      t.string :name, null: false
      t.string :phone
      t.string :email
      t.string :address
      t.references :addressable, polymorphic: true, null: false
      t.references :ward, foreign_key: { to_table: :administrative_units }
      t.references :district, foreign_key: { to_table: :administrative_units }
      t.references :province, foreign_key: { to_table: :administrative_units }
      t.string :note
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end

    create_table :companies do |t|
      t.references :account, null: false, foreign_key: true
      t.string :registration_name
      t.string :registration_no, index: { unique: true }
      t.date :registration_date
      t.string :legal_type
      t.string :status, null: false, default: 'active'

      t.timestamps
    end
  end
end
