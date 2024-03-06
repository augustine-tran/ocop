# frozen_string_literal: true

class FinalAssessmentsController < ApplicationController
  before_action :set_assessment, only: %i[show edit update]
  before_action :set_submission, only: %i[show edit update]

  def show; end

  def edit; end

  def update
    if @assessment.submit
      redirect_to final_assessment_path(@assessment), notice: 'Final assessment was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_assessment
    @assessment = Assessment.find(params[:id])
  end

  def set_submission
    @submission = @assessment.submission
  end
end
