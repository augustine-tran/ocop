# frozen_string_literal: true

class SubmissionsController < ApplicationController
  before_action :set_submission, only: %i[show edit update destroy]

  def index
    @submissions = Submission.all
  end

  def show; end

  def new
    @submission = Submission.build
  end

  def edit; end

  def create
    @submission = Submission.build(submission_params)

    if @submission.save
      redirect_to submission_path(@submission), notice: t(:created_successfully)
    else
      render :new
    end
  end

  def update
    if @submission.update(submission_params)
      redirect_to submission_path(@submission), notice: t(:updated_successfully)
    else
      render :edit
    end
  end

  def destroy
    @submission.destroy
    redirect_to submissions_path, notice: t(:destroyed_successfully)
  end

  private

  def set_submission
    @submission = Submission.find(params[:id])
  end

  def submission_params
    params.require(:submission).permit(:name, :status, :description, :product_group, photos: [])
  end
end
