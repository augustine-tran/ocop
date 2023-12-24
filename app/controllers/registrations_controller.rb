# frozen_string_literal: true

class RegistrationsController < ApplicationController
  skip_before_action :authenticate

  def index; end

  layout 'guest'

  def new
    @account = Account.new
    @identity = Identity.new
  end

  def create
    ActiveRecord::Base.transaction do
      @account = Account.create!(account_params)
      @identity = Identity.create!(identity_params)

      user = User.create!(identity: @identity)
      @account.people.create!(personable: user, role: 'admin')

      session_record = @identity.sessions.create!
      cookies.signed.permanent[:session_token] = { value: session_record.id, httponly: true }

      send_email_verification
      redirect_to root_path, notice: t(:signed_up)
    end
  rescue ActiveRecord::RecordInvalid
    @account = Account.new(account_params)
    @identity = Identity.new(identity_params)
    render :new, status: :unprocessable_entity
  end

  private

  def account_params
    params.require(:account).permit(:name)
  end

  def identity_params
    params.require(:identity).permit(:name, :email, :password, :password_confirmation)
  end

  def send_email_verification
    UserMailer.with(user: Current.person).email_verification.deliver_later
  end
end
