# frozen_string_literal: true

class FinalSubmissions::DifferencesController < ApplicationController
  before_action :set_submission

  def index
    @assessments = Assessment.find(assessment_ids_params)
    @final_assessment = @submission.final_assessment
  end

  private

  def set_submission
    @submission = Submission.find(params[:final_submission_id])
  end

  def assessment_ids_params
    params[:assessment_ids]
  end
end
