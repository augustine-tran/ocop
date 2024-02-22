# frozen_string_literal: true

class CreateSessions < ActiveRecord::Migration[7.1]
  def change
    create_table :sessions do |t|
      t.references :identity, null: false, foreign_key: true, index: true
      t.string :ip_address
      t.string :user_agent

      t.timestamps
    end
  end
end
