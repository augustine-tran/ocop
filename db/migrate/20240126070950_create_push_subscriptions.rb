# frozen_string_literal: true
class CreatePushSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :push_subscriptions do |t|
      t.references :person, null: false, foreign_key: true

      t.string :endpoint
      t.string :p256dh_key
      t.string :auth_key
      t.string :user_agent

      t.timestamps

      t.index :endpoint, unique: true
      t.index %w[endpoint p256dh_key auth_key]
    end
  end
end
