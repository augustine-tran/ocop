# frozen_string_literal: true

class FinalSubmissionsController < ApplicationController
  before_action :set_submission, only: %i[show]
  before_action :set_assessment, only: %i[show]

  def index
    @submissions = Current.person.final_submissions
  end

  def show; end

  private

  def set_submission
    @submission = Submission.find(params[:id])
  end

  def set_assessment
    @assessment = @submission.final_assessment
  end
end
