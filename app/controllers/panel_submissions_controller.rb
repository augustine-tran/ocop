# frozen_string_literal: true

class PanelSubmissionsController < ApplicationController
  before_action :set_submission, only: %i[show]
  before_action :set_assessment, only: %i[show]

  def index
    @q = Current.person.panel_submissions.ransack(params[:q])
    @submissions = @q.result.order(updated_at: :desc).page(params[:page]).per(10)
  end

  def show; end

  private

  def set_submission
    @submission = Submission.find(params[:id])
  end

  def set_assessment
    @assessment = @submission.assessment_for(Current.person)
  end
end
