# frozen_string_literal: true

class FinalAssessmentsController < ApplicationController
  before_action :set_assessment, only: %i[show]
  before_action :set_submission, only: %i[show]

  def show; end

  private

  def set_assessment
    @assessment = Assessment.find(params[:id])
  end

  def set_submission
    @submission = @assessment.submission
  end
end
