# frozen_string_literal: true

class SelfAssessment < ApplicationRecord
  include Assessable

  def notify_submission
    assessment.submission.finish_self_assessment
  end

  def can_submit?
    assessment.drafted? && assessment.scored_all?
  end
end
