# frozen_string_literal: true

class CreateEmployees < ActiveRecord::Migration[7.1]
  def change
    create_table :employees do |t|
      t.string :title
      t.string :description
      t.string :position
      t.string :job_title
      t.references :manager, foreign_key: { to_table: :recordings }

      t.timestamps
    end
  end
end
