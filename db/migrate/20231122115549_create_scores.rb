# frozen_string_literal: true

class CreateScores < ActiveRecord::Migration[7.1]
  def change
    create_table :scores do |t|
      t.references :assessment, null: false
      t.string :level, null: false, default: 'node_roots'
      t.references :parent, foreign_key: { to_table: :scores }
      t.references :criterium, null: false, foreign_key: true
      t.references :criterion, foreign_key: { to_table: :criteria }
      t.integer :score, null: false, default: 0

      t.timestamps
    end
  end
end
