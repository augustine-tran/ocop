class CreateCouncils < ActiveRecord::Migration[7.1]
  def change
    create_table :councils do |t|
      t.references :account, null: false, foreign_key: true
      t.references :councilable, polymorphic: true, null: false
      t.string :name, null: false

      t.timestamps
    end

    create_table :ocop_councils, &:timestamps
  end
end
