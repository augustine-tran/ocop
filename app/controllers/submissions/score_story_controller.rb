# frozen_string_literal: true

class Submissions::ScoreStoryController < ApplicationController
  before_action :set_score

  def show
    authorize! :read, @score.scorable

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def edit; end

  def update
    if @score.update(score_params.except(:photos_to_remove, :files_to_remove))
      remove_photos(score_params[:photos_to_remove]) if score_params[:photos_to_remove].present?
      remove_files(score_params[:files_to_remove]) if score_params[:files_to_remove].present?
      redirect_to submission_scores_path(@score.scorable), notice: 'Score was successfully updated.'
    else
      render :edit
    end
  end

  def move_image
    authorize! :edit, @score.scorable

    @image = @score.photos[params[:old_position].to_i - 1]
    @image.insert_at(params[:new_position].to_i)
    head :ok
  end

  private

  def score_params
    params.require(:score).permit(:story, photos_to_remove: [], files_to_remove: [], photos: [], files: [])
  end

  def set_score
    @score = Score.find(params[:id])
  end

  def remove_photos(photos_to_remove)
    @score.photos.where(id: photos_to_remove).map(&:purge)
  end

  def remove_files(files_to_remove)
    @score.files.where(id: files_to_remove).map(&:purge)
  end
end
