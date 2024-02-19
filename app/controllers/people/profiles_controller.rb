# frozen_string_literal: true

class People::ProfilesController < ApplicationController
  before_action :set_person
  def show; end

  private

  def set_person
    @person = Current.person
  end
end
