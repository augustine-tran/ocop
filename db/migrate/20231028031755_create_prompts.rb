# frozen_string_literal: true

class CreatePrompts < ActiveRecord::Migration[7.1]
  def change
    create_table :prompts do |t|
      t.string :title
      t.binary :prompt_image
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
