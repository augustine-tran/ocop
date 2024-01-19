# frozen_string_literal: true

class CreateSubmissions < ActiveRecord::Migration[7.1]
  def change
    create_table :submissions do |t|
      t.string :name, null: false
      t.string :description
      t.string :submission_type
      t.string :product_group, null: false, default: 'group1'
      t.string :status, null: false, default: 'active'
      t.string :round, null: false, default: 'self'
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
