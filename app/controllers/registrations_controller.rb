# frozen_string_literal: true

class RegistrationsController < ApplicationController
  allow_unauthenticated_access only: %i[new create]

  def index; end

  layout 'guest'

  def new
    @identity = Identity.new
  end

  def create
    ActiveRecord::Base.transaction do
      # TODO: This is a temporary solution to create the first account
      @account = Account.first!

      user = User.create! identity: Identity.new(identity_params)
      @account.people.create! personable: user

      send_email_verification

      start_new_session_for user.identity

      redirect_to root_path, notice: t(:signed_up)
    end
  rescue ActiveRecord::RecordInvalid
    @user = User.new(user_params)
    render :new, status: :unprocessable_entity
  end

  private

  def identity_params
    params.require(:identity).permit(:name, :email, :password, :password_confirmation)
  end

  def send_email_verification
    UserMailer.with(user: Current.person).email_verification.deliver_later
  end
end
