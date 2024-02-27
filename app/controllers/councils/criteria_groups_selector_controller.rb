# frozen_string_literal: true

class Councils::CriteriaGroupsSelectorController < ApplicationController
  def index
    begin
      @council = Council.find(params[:council_id])
      @groups = CriteriaGroup.where(criteria_bucket_id: @council.criteria_bucket_id).order(:name)
    rescue ActiveRecord::RecordNotFound
      @groups = []
    end

    render partial: 'options', locals: { groups: @groups }
  end
end
