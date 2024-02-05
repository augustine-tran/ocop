# frozen_string_literal: true

class FinalSubmissions::AssessmentsController < ApplicationController
  before_action :set_submission

  def index
    @assessments = @submission.panel_assessments
  end

  private

  def set_submission
    @submission = Submission.find(params[:final_submission_id])
  end
end
