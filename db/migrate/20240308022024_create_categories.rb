# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.references :parent, foreign_key: { to_table: :categories }
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
