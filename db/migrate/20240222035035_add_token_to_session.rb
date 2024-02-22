class AddTokenToSession < ActiveRecord::Migration[7.1]
  def change
    change_table :sessions, bulk: true do |t|
      t.string :token, null: false, default: ''
      t.datetime :last_active_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.index :token, unique: true
    end
  end
end
