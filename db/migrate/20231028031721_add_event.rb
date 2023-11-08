# frozen_string_literal: true

class AddEvent < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.references :recording, null: false, foreign_key: true
      t.references :recordable, polymorphic: true, null: false
      t.references :recordable_previous, polymorphic: true
      t.references :creator, null: false, foreign_key: { to_table: :people }
      t.string :action, null: false
      t.string :status_was

      t.timestamps
    end

    create_table :event_details do |t|
      t.references :event, null: false, foreign_key: true
      t.boolean :title_changed, default: false, null: false
      t.boolean :description_changed, default: false, null: false

      t.timestamps
    end
  end
end
