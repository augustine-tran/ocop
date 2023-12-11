# frozen_string_literal: true

class Submissions::ScoresController < ApplicationController
  before_action :set_submission
  before_action :set_score, only: %i[show edit update destroy]

  def index
    @scores = @submission.scores
  end

  def show; end

  def new; end

  def edit; end

  def update
    if @score.update(score_params)
      redirect_to submission_scores_path(@submission), notice: 'Score was successfully updated.'
    else
      render :edit
    end
  end

  def destroy; end

  private

  def set_submission
    @submission = Submission.find(params[:submission_id])
  end

  def set_score
    @score = Score.find(params[:id])
  end

  def score_params
    params.require(:score).permit(:criterion_id)
  end
end
