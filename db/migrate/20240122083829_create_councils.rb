class CreateCouncils < ActiveRecord::Migration[7.1]
  def change
    create_table :councils do |t|
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
