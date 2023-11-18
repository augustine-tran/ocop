class CreateSubmissions < ActiveRecord::Migration[7.1]
  def change
    create_table :submissions do |t|
      t.string :title
      t.string :submission_type

      t.timestamps
    end
  end
end
