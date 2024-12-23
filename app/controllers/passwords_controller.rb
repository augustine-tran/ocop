# frozen_string_literal: true

class PasswordsController < ApplicationController
  before_action :set_identity

  def edit; end

  def update
    if @identity.update(user_params)
      redirect_to root_path, notice: t('your_password_changed')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_identity
    @identity = Current.identity
  end

  def user_params
    params.permit(:password, :password_confirmation, :password_challenge).with_defaults(password_challenge: '')
  end
end
