class CreateScores < ActiveRecord::Migration[7.1]
  def change
    create_table :scores do |t|
      t.references :scorable, polymorphic: true, null: false
      t.references :criterium, null: false, foreign_key: true
      t.integer :score
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
