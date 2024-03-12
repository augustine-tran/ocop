# frozen_string_literal: true

class AssistantSubmissionsController < ApplicationController
  before_action :set_submission, only: %i[show]
  before_action :set_assessment, only: %i[show]

  def index
    @q = Current.person.submissions.ransack(params[:q])
    @submissions = @q.result.except_drafted.page(params[:page]).order(updated_at: :desc).per(10)
  end

  def show; end

  private

  def set_submission
    @submission = Submission.find(params[:id])
  end

  def set_assessment
    @assessment = @submission.self_assessment
  end
end
