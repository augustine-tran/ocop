# frozen_string_literal: true

class CreateSubmissions < ActiveRecord::Migration[7.1]
  def change
    create_table :submissions do |t|
      t.string :title
      t.string :submission_type
      t.string :product_group, null: false, default: 'group1'
      t.references :product, foreign_key: { to_table: :products }
      t.references :account, null: false, foreign_key: true
      t.string :status, null: false, default: 'active'

      t.timestamps
    end
  end
end
