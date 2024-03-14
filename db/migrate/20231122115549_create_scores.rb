# frozen_string_literal: true

class CreateScores < ActiveRecord::Migration[7.1]
  def change
    create_table :scores do |t|
      t.string :title, null: false
      t.string :description
      t.references :assessment, null: false
      t.integer :level, null: false, default: 0
      t.integer :stars
      t.integer :star_3
      t.integer :star_4
      t.integer :star_5
      t.references :parent, foreign_key: { to_table: :scores }
      t.references :criterium, null: false, foreign_key: true
      t.references :criterion, foreign_key: { to_table: :criteria }
      t.numeric :score, null: false, default: 0

      t.timestamps
    end
  end
end
