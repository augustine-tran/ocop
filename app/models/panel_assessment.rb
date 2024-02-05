# frozen_string_literal: true

class PanelAssessment < ApplicationRecord
  include Assessable

  def notify_submission
    assessment.submission.finish_panel_assessment assessment
  end
end
