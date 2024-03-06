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

    assessment.update status: :active, star: assessment.suggested_stars
  end
end
