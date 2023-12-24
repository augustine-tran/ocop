# frozen_string_literal: true

class Identity::PasswordResetsController < ApplicationController
  skip_before_action :authenticate

  before_action :set_user, only: %i[edit update]

  def new
    render layout: 'guest'
  end

  def edit; end

  def create
    if (@user = User.find_by(email: params[:email], verified: true))
      send_password_reset_email
      redirect_to sign_in_path, notice: t('password_reset_instruction')
    else
      redirect_to new_identity_password_reset_path, alert: t('verify_email_to_reset_password')
    end
  end

  def update
    if @user.update(user_params)
      redirect_to sign_in_path, notice: t('your_password_changed')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find_by_token_for!(:password_reset, params[:sid])
  rescue StandardError
    redirect_to new_identity_password_reset_path, alert: t('invalid_link_reset_password')
  end

  def user_params
    params.permit(:password, :password_confirmation)
  end

  def send_password_reset_email
    UserMailer.with(user: @user).password_reset.deliver_later
  end
end
