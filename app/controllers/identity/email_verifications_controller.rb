# frozen_string_literal: true

class Identity::EmailVerificationsController < ApplicationController
  allow_unauthenticated_access only: %i[show]

  before_action :set_user, only: :show

  def show
    @user.update! verified: true
    redirect_to root_path, notice: t('Thank you for verifying your email address')
  end

  def create
    send_email_verification
    redirect_to root_path, notice: 'We sent a verification email to your email address'
  end

  private

  def set_user
    @user = User.find_by_token_for!(:email_verification, params[:sid])
  rescue StandardError
    redirect_to edit_identity_email_path, alert: 'That email verification link is invalid'
  end

  def send_email_verification
    UserMailer.with(user: Current.identity).email_verification.deliver_later
  end
end
