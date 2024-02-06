# frozen_string_literal: true

class FinalAssessment < ApplicationRecord
  include Assessable

  def notify_submission
    assessment.submission.finish_final_assessment
  end

  def can_submit?
    assessment.drafted? && submission.assessments.drafted.count.zero?
  end
end
