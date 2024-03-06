class AddStarToAssessment < ActiveRecord::Migration[7.1]
  def change
    add_column :assessments, :star, :integer
  end
end
