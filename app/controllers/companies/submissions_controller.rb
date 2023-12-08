# frozen_string_literal: true

class Companies::SubmissionsController < ApplicationController
  before_action :set_company
  before_action :set_submission, only: %i[show edit update destroy]

  def index
    @submissions = @company.submissions
  end

  def show; end

  def new
    @submission = @company.submissions.build
  end

  def edit; end

  def create
    @submission = @company.submissions.build(submission_params)

    if @submission.save
      redirect_to company_submission_path(@company, @submission), notice: 'Submission was successfully created.'
    else
      render :new
    end
  end

  def update
    if @submission.update(submission_params)
      redirect_to company_submission_path(@company, @submission), notice: 'Submission was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @submission.destroy
    redirect_to company_submissions_path(@company), notice: 'Submission was successfully destroyed.'
  end

  private

  def set_company
    @company = Company.find(params[:company_id])
  end

  def set_submission
    @submission = @company.submissions.find(params[:id])
  end

  def submission_params
    params.require(:submission).permit(:name, :status, :description, :product_group, photos: [])
  end
end
