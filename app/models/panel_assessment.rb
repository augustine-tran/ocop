# frozen_string_literal: true

class PanelAssessment < ApplicationRecord
  include Assessable

  def notify_submission
    assessment.submission.finish_panel_assessment assessment
  end

  def can_submit?
    assessment.drafted? && assessment.scored_all?
  end

  def submit
    assessment.update status: :active
  end
end
