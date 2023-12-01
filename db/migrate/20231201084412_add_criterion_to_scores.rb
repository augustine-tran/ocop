# frozen_string_literal: true

class AddCriterionToScores < ActiveRecord::Migration[7.1]
  def change
    add_reference :scores, :criterion, foreign_key: { to_table: :criteria }
  end
end
