# frozen_string_literal: true

class PanelSubmissions::DifferencesController < ApplicationController
  before_action :set_submission

  def index
    @assessments = @submission.paired_assessments_too_different
  end

  def destroy
    Submission.transaction do
      @submission.panel_assessments.find(params[:assessment_ids]).compact.each do |assessment|
        assessment.update status: :drafted
      end
    end
    redirect_to panel_submission_differences_path(@submission), notice: 'Đã gởi yêu cầu đánh giá lại'
  end

  private

  def set_submission
    @submission = Submission.find(params[:panel_submission_id])
  end
end
