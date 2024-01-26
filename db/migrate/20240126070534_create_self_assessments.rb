# frozen_string_literal: true

class CreateSelfAssessments < ActiveRecord::Migration[7.1]
  def change
    create_table :self_assessments, &:timestamps
  end
end
