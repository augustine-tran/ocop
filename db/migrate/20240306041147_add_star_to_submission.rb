# frozen_string_literal: true

class AddStarToSubmission < ActiveRecord::Migration[7.1]
  def change
    add_column :submissions, :star, :integer, default: 0
  end
end
