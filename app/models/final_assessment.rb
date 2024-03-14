# frozen_string_literal: true

class FinalAssessment < ApplicationRecord
  include Assessable

  def notify_submission
    assessment.submission.finish_final_assessment
  end

  def can_submit?
    assessment.drafted? && submission.panel_assessments.drafted.count.zero?
    # TODO: - make sure scores between panels are not different over a certain threshold
    # TODO: - make sure scores ranking requirements are met
  end

  def submit
    return unless can_submit?

    assessment.update status: :active, star: assessment.max_rank
  end

  def update_scores_from_panel_assessments
    ids = assessment.submission.panel_assessments.pluck(:id)
    transaction do
      assessment.scores.node_subs.each do |s|
        s.update score: Score.where(assessment_id: ids, criterium_id: s.criterium_id).average(:score)
      end
    end
  end
end
