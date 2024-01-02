# frozen_string_literal: true

class Submissions::AttachmentPositionsController < ApplicationController
  before_action :set_submission

  def move_image
    authorize! :edit, @submission

    @image = @submission.photos[params[:old_position].to_i - 1]
    @image.insert_at(params[:new_position].to_i)
    head :ok
  end

  private

  def set_submission
    @submission = Submission.find(params[:id])
  end
end
