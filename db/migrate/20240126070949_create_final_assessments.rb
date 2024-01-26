# frozen_string_literal: true

class CreateFinalAssessments < ActiveRecord::Migration[7.1]
  def change
    create_table :final_assessments do |t|
      t.references :judge, null: false, foreign_key: { to_table: :people }
      t.string :level, null: false, default: 'district'

      t.timestamps
    end
  end
end