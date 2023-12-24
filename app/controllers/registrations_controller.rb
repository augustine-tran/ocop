# frozen_string_literal: true

class RegistrationsController < ApplicationController
  skip_before_action :authenticate

  def index; end

  layout 'guest'

  def new
    @identity = Identity.new
    @identity.clients.build.build_company
  end

  def create
    @identity = Identity.new(identity_params)

    if @identity.save
      Current.account = Account.first!
      Current.person = Current.account.people.create!(personable: @identity.clients.first)

      session_record = @identity.sessions.create!
      cookies.signed.permanent[:session_token] = { value: session_record.id, httponly: true }

      send_email_verification
      redirect_to root_path, notice: 'Welcome! You have signed up successfully'
    else
      @identity.clients.build.build_company
      render :new, status: :unprocessable_entity
    end
  end

  private

  def identity_params
    params.require(:identity).permit(:name, :email, :password, :password_confirmation,
                                     clients_attributes: [company_attributes: %i[name registration_no]])
  end

  def send_email_verification
    UserMailer.with(user: @user).email_verification.deliver_later
  end
end
