# frozen_string_literal: true

module AssessmentsHelper
  def submit_assessment_button_text(assessment)
    if assessment.self_assessment?
      t('.submit_assessment')
    elsif assessment.panel_assessment?
      t('.submit_panel_assessment')
    else
      t('.submit_final_assessment')
    end
  end
end
