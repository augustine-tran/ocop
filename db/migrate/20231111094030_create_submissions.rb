# frozen_string_literal: true

class CreateSubmissions < ActiveRecord::Migration[7.1]
  def change
    create_table :submissions do |t|
      t.string :name, null: false
      t.references :council, null: false, foreign_key: true
      t.references :criteria_group, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.string :description
      t.string :status, null: false, default: :drafted
      t.references :creator, foreign_key: { to_table: :people }
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
