# frozen_string_literal: true

class AddRecording < ActiveRecord::Migration[7.1]
  def change
    create_enum :recording_status_type, %w[drafted active archived trashed]

    create_table :recordings do |t|
      t.references :account, null: false, foreign_key: true
      t.references :creator, null: false, foreign_key: { to_table: :people }
      t.references :parent, foreign_key: { to_table: :recordings }
      t.references :recordable, polymorphic: true, null: false
      t.string :status, null: false

      t.timestamps
    end
  end
end
