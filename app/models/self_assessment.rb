# frozen_string_literal: true

class SelfAssessment < ApplicationRecord
  include Assessable

  def notify_submission
    assessment.submission.finish_self_assessment
  end

  def can_submit?
    assessment.drafted?
  end

  def submit
    return unless can_submit?

    transaction do
      assessment.update(status: :approval, star: assessment.max_rank)
      assessment.submission.update(status: :approval)
    end
  end
end
