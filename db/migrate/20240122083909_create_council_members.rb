# frozen_string_literal: true

class CreateCouncilMembers < ActiveRecord::Migration[7.1]
  def change
    create_table :council_members do |t|
      t.references :council, null: false, foreign_key: true
      t.references :person, null: false, foreign_key: true
      t.string :role

      t.timestamps
    end
  end
end
