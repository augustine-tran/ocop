# frozen_string_literal: true

class PanelSubmissions::AssessmentsController < ApplicationController
  before_action :set_submission

  def index
    @assessments = @submission.panel_assessments
  end

  private

  def set_submission
    @submission = Submission.find(params[:panel_submission_id])
  end
end
