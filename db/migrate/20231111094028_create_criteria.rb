# frozen_string_literal: true

class CreateCriteria < ActiveRecord::Migration[7.1]
  def change
    create_table :criteria do |t|
      t.string :title
      t.string :description
      t.references :parent, foreign_key: { to_table: :criteria }
      t.integer :year, null: false, default: 2024
      t.integer :level
      t.integer :score
      t.boolean :leaf, null: false, default: 0

      t.timestamps
    end
  end
end
