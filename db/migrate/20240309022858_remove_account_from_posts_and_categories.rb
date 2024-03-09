# frozen_string_literal: true

class RemoveAccountFromPostsAndCategories < ActiveRecord::Migration[7.1]
  def change
    remove_reference :posts, :account, null: false, foreign_key: true
    remove_reference :categories, :account, null: false, foreign_key: true
  end
end
