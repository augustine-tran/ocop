class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :status, null: false, default: 'active'
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
