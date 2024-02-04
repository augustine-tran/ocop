# frozen_string_literal: true

class SubmissionsController < ApplicationController
  before_action :set_submission, only: %i[show edit update destroy]
  before_action :set_company, only: %i[index]
  before_action :set_assessment, only: %i[show]

  def index
    @submissions = if Current.account.company?
                     Current.account.submissions
                   else
                     Current.account.managed_submissions
                   end
  end

  def show; end

  def new
    @submission = Submission.build
  end

  def edit; end

  def create
    @submission = Submission.build(submission_params)
    @submission.account = Current.account

    if @submission.save
      redirect_to submission_path(@submission), notice: t(:created_successfully)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @submission.update(submission_params.except(:photos_to_remove))
      remove_photos(submission_params[:photos_to_remove]) if submission_params[:photos_to_remove].present?
      redirect_to submission_path(@submission), notice: t(:updated_successfully)
    else
      render :edit, status: :unprocessable_entity
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

  def set_company
    @company = Company.find(request.query_parameters[:company_id]) if request.query_parameters[:company_id].present?
  end

  def set_assessment
    @assessment = if Current.account == @submission.account
                    @submission.self_assessment
                  else
                    @submission.assessment_for(Current.person)
                  end
  end

  def submission_params
    params.require(:submission).permit(:name, :status, :description, :product_group, photos: [], photos_to_remove: [])
  end

  def remove_photos(photos_to_remove)
    @submission.photos.where(id: photos_to_remove).map(&:purge)
  end
end
