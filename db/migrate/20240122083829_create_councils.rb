class CreateCouncils < ActiveRecord::Migration[7.1]
  def change
    create_table :councils do |t|
      t.references :account, null: false, foreign_key: true
      t.references :criteria_bucket, null: false, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
