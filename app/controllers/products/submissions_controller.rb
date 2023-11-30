# frozen_string_literal: true

class Products::SubmissionsController < ApplicationController
  before_action :set_product
  before_action :set_submission, only: %i[show edit update destroy]

  def index
    @submissions = @product.submissions
  end

  def show; end

  def new
    @submission = @product.submissions.build
  end

  def edit; end

  def create
    @submission = @product.submissions.build(submission_params)

    if @submission.save
      redirect_to product_submission_path(@product, @submission), notice: 'Submission was successfully created.'
    else
      render :new
    end
  end

  def update
    if @submission.update(submission_params)
      redirect_to product_submission_path(@product, @submission), notice: 'Submission was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @submission.destroy
    redirect_to product_submissions_path(@product), notice: 'Submission was successfully destroyed.'
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_submission
    @submission = @product.submissions.find(params[:id])
  end

  def submission_params
    params.require(:submission).permit(:title, :status, :description, photos: [])
  end
end
