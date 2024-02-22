# frozen_string_literal: true

class CouncilsController < ApplicationController
  def index
    @councils = Council.all
  end
end
