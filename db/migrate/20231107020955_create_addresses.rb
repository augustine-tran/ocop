# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.string :title, null: false
      t.string :phone
      t.string :email
      t.string :address
      t.references :ward, foreign_key: true
      t.references :district, foreign_key: true
      t.references :province, foreign_key: true
      t.string :note

      t.timestamps
    end
  end
end