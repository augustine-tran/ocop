# frozen_string_literal: true

class AssessmentsController < ApplicationController
  before_action :set_assessment
  before_action :set_submission

  def show; end

  def edit; end

  def submit
    if @assessment.submit
      if Current.person.user?
        redirect_to submission_path(@assessment.submission), notice: t(:submitted_successfully)
      else
        redirect_to panel_submission_path(@assessment.submission), notice: t(:submitted_successfully)
      end

    else
      redirect_to assessment_path(@assessment)
    end
  end

  private

  def set_assessment
    @assessment = Assessment.find(params[:id])
    @submission = @assessment.submission
  end

  def set_submission
    @submission = @assessment.submission
  end
end
