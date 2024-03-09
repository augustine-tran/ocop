# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :title, null: false
      t.string :status, default: 'drafted'
      t.string :slug, null: false
      t.integer :stars, default: 0
      t.references :company, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true

      t.timestamps

      t.index :slug, unique: true
      t.index :stars
      t.index :status
    end
  end
end
