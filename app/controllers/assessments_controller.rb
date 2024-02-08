# frozen_string_literal: true

class AssessmentsController < ApplicationController
  before_action :set_assessment

  def show; end

  def edit; end

  def submit
    if @assessment.submit
      redirect_to submission_path(@assessment.submission), notice: 'Assessment was successfully submitted.'

    else
      redirect_to edit_assessment_path(@assessment)
    end
  end

  private

  def set_assessment
    @assessment = Assessment.find(params[:id])
  end
end
