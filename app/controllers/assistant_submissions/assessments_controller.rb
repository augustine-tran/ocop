# frozen_string_literal: true

class AssistantSubmissions::AssessmentsController < ApplicationController
  before_action :set_assessment
  before_action :set_submission

  def show; end

  def edit; end

  def approve
    if @assessment.approve
      redirect_to assistant_submission_path(@assessment.submission), notice: t(:submission_approved)

    else
      redirect_to edit_assistant_submission_assessment_path(@submission, @assessment)
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
