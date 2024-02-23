# frozen_string_literal: true

class CreateCriteria < ActiveRecord::Migration[7.1]
  def change
    create_table :criteria_buckets do |t|
      t.string :name
      t.references :account, null: false, foreign_key: true
      t.string :description
      t.integer :year, null: false, default: 2024
      t.string :status, null: false, default: 'active'

      t.timestamps
    end

    create_table :criteria_groups do |t|
      t.string :name
      t.references :criteria_bucket, null: false, foreign_key: true
      t.string :description
      t.string :status, null: false, default: 'active'

      t.timestamps
    end

    create_table :criteria do |t|
      t.string :title
      t.references :criteria_group, null: false, foreign_key: true
      t.references :parent, foreign_key: { to_table: :criteria }
      t.string :description
      t.integer :level
      t.integer :score
      t.boolean :leaf, null: false, default: 0
      t.string :status, null: false, default: 'active'

      t.timestamps
    end
  end
end
