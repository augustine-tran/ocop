class CreateAdministrativeUnits < ActiveRecord::Migration[7.1]
  def change
    create_table :administrative_units do |t|
      t.string :name
      t.string :code
      t.string :level

      t.timestamps
    end
  end
end
