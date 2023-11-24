# frozen_string_literal: true

class CreateEmployees < ActiveRecord::Migration[7.1]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :description
      t.string :position
      t.string :job_title
      t.references :manager, foreign_key: { to_table: :recordings }
      t.string :status, null: false, default: 'active'
      t.references :company, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
