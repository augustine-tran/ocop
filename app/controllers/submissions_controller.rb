# frozen_string_literal: true

class SubmissionsController < ApplicationController
  before_action :set_submission, only: %i[show edit update destroy]
  before_action :set_assessment, only: %i[show]

  def index
    @submissions = Current.person.my_submissions
  end

  def show; end

  def new
    if Current.person.companies.count.zero?
      redirect_to new_company_path(back_url: new_submission_url),
                  notice: t(:create_company_first)
    end

    @submission = Submission.build company: Current.person.companies.first
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
    if @submission.update(submission_params.except(:files_to_remove))
      remove_photos(submission_params[:files_to_remove]) if submission_params[:files_to_remove].present?
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

  def set_assessment
    @assessment = if Current.account == @submission.account
                    @submission.self_assessment
                  else
                    @submission.assessment_for(Current.person)
                  end
  end

  def submission_params
    params.require(:submission).permit(:name, :status, :description, :company_id,
                                       :council_id, :criteria_group_id,
                                       files: [], files_to_remove: [])
  end

  def remove_photos(files_to_remove)
    @submission.files.where(id: files_to_remove).map(&:purge)
  end
end
