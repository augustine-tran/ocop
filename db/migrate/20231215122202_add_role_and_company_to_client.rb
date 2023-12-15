# frozen_string_literal: true

class AddRoleAndCompanyToClient < ActiveRecord::Migration[7.1]
  def change
    change_table :clients do |t|
      t.string :role
      t.references :company, null: false, foreign_key: true
    end
  end
end
