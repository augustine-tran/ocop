# frozen_string_literal: true

class FinalSubmissions::AssessmentsController < ApplicationController
  before_action :set_submission
  before_action :set_assessment, only: %i[submit]

  def index
    @assessments = @submission.panel_assessments
  end

  def submit
    if @assessment.submit
      redirect_to final_submission_path(@submission), notice: 'Assessment was successfully submitted.'

    else
      redirect_to final_submission_path(@submission)
    end
  end

  private

  def set_submission
    @submission = Submission.find(params[:final_submission_id])
  end

  def set_assessment
    @assessment = @submission.final_assessment
  end
end
