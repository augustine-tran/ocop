# frozen_string_literal: true

class Assessments::ScoresController < ApplicationController
  before_action :set_assessment
  before_action :set_score, only: %i[update]

  def update
    if @score.update(score_params)
      redirect_to edit_assessment_path(@assessment), notice: 'Score was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_assessment
    @assessment = Assessment.find(params[:assessment_id])
  end

  def set_score
    @score = Score.find(params[:id])
  end

  def score_params
    params.require(:score).permit(:criterion_id)
  end
end
