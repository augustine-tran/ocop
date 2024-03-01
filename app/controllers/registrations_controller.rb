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

      user = User.create! identity: Identity.create!(identity_params)
      @account.people.create! personable: user

      send_email_verification

      start_new_session_for user.identity

      redirect_to root_path, notice: I18n.t('registrations.create.success')
    end
  rescue ActiveRecord::RecordInvalid
    @identity = Identity.new(identity_params)
    flash.now[:alert] = I18n.t('registrations.create.invalid')
    render :new, status: :unprocessable_entity
  end

  private

  def identity_params
    params.require(:identity).permit(:name, :email, :password)
  end

  def send_email_verification
    UserMailer.with(user: Current.person).email_verification.deliver_later
  end
end
