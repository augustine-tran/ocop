class CreateEvidences < ActiveRecord::Migration[7.1]
  def change
    create_table :evidences do |t|
      t.references :score, null: false, foreign_key: true

      t.timestamps
    end
  end
end
