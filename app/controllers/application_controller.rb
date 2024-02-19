# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ActiveStorage::SetCurrent
  include Authentication

  protected

  def current_ability
    @current_ability ||= Ability.new(Current.person)
  end

  def current_session
    @current_session ||= Current.session
  end
  helper_method :current_session
end
