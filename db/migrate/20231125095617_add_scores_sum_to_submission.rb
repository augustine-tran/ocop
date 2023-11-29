class AddScoresSumToSubmission < ActiveRecord::Migration[7.1]
  def change
    add_column :submissions, :scores_sum, :integer
  end
end
