class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :status
      t.references :company, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
    add_index :products, :status
  end
end
