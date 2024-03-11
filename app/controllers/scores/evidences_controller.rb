# frozen_string_literal: true

class Scores::EvidencesController < ApplicationController
  before_action :set_score
  before_action :set_evidence, only: %i[show edit update destroy move_image index]

  def index
    redirect_to score_evidence_path(@score, @evidence) if @evidence.present? && @evidence.files.present?
  end

  def show; end

  def new
    @evidence = @score.build_evidence
  end

  def edit; end

  def create
    @evidence = @score.build_evidence(evidence_params)
    @evidence.criterium_id = @score.criterium_id

    if @evidence.save
      redirect_to score_evidence_path(@score, @evidence), notice: t(:create_success, name: Evidence.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @evidence.update(evidence_params.except(:files_to_remove))
      remove_files(evidence_params[:files_to_remove]) if evidence_params[:files_to_remove].present?

      redirect_to score_evidence_path(@score, @evidence), notice: t(:update_success, name: Evidence.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy; end

  def move_image
    # authorize! :edit, @score.assessment

    @file = @evidence.files[params[:old_position].to_i - 1]
    @file.insert_at(params[:new_position].to_i)
    head :ok
  end

  private

  def set_score
    @score = Score.find(params[:score_id])
  end

  def set_evidence
    @evidence = @score.evidence ||
                @score.assessment.submission.self_assessment&.evidences&.find_by(criterium_id: @score.criterium_id)
  end

  def evidence_params
    params.require(:evidence).permit(:story, files_to_remove: [], files: [])
  end

  def remove_files(files_to_remove)
    @evidence.files.where(id: files_to_remove).map(&:purge)
  end
end
