# frozen_string_literal: true

class PanelAssessmentsController < ApplicationController
  before_action :set_panel_assessment, only: %i[show]

  def index
    @assessments = Current.person.panel_assessments
  end

  def show; end

  private

  def set_panel_assessment
    @assessment = Assessment.find(params[:id])
  end
end
