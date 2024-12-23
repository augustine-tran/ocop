# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.string :status, null: false, default: :drafted
      t.references :category, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true

      t.timestamps

      t.index :slug, unique: true
    end
  end
end
