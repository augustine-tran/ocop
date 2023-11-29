# frozen_string_literal: true

class RegistrationsController < ApplicationController
  skip_before_action :authenticate

  def new
    @identity = Identity.new
  end

  def create
    @identity = Identity.new(identity_params)

    if @identity.save
      user_record = @identity.users.create!
      user_record.create_person!(account: Account.first!)
      session_record = @identity.sessions.create!
      cookies.signed.permanent[:session_token] = { value: session_record.id, httponly: true }

      send_email_verification
      redirect_to root_path, notice: 'Welcome! You have signed up successfully'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def identity_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

  def send_email_verification
    UserMailer.with(user: @user).email_verification.deliver_later
  end
end
