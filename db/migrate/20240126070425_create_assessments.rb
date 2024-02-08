# frozen_string_literal: true

class CreateAssessments < ActiveRecord::Migration[7.1]
  def change
    create_table :assessments do |t|
      t.references :submission, null: false, foreign_key: true
      t.references :assessable, polymorphic: true, null: false
      t.integer :scores_sum, null: false, default: 0
      t.string :status, null: false, default: 'drafted'
      t.references :judge, foreign_key: { to_table: :people }

      t.timestamps
    end
  end
end
