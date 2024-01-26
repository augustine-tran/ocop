# frozen_string_literal: true

class AssessmentsController < ApplicationController
  before_action :set_assessment, only: %i[show]

  def show; end

  private

  def set_assessment
    @assessment = Assessment.find(params[:id])
  end
end
