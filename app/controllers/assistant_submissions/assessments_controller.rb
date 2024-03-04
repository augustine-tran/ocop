# frozen_string_literal: true

class AssistantSubmissions::AssessmentsController < ApplicationController
  before_action :set_assessment
  before_action :set_submission

  def show; end

  def edit; end

  def approve
    if @assessment.approve
      redirect_to submission_path(@assessment.submission), notice: 'Assessment was successfully submitted.'

    else
      redirect_to edit_assessment_path(@assessment)
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
