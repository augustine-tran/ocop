# frozen_string_literal: true

class Councils::MembersController < ApplicationController
  before_action :set_council
  def index
    @members = @council.members
  end

  private

  def set_council
    @council = Council.find(params[:council_id])
  end
end
