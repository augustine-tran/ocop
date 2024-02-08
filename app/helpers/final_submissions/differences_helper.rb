# frozen_string_literal: true

module FinalSubmissions::DifferencesHelper
  def judge_selected_for(criterium_id, assessment)
    assessment.scores.find_by(criterium_id:)&.criterion
  end
end
