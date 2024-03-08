# frozen_string_literal: true

class AddSourceToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :source, :string
  end
end
