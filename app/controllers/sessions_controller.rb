# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authenticate, only: %i[new create]

  before_action :set_session, only: :destroy

  def index
    @sessions = Current.identity.sessions.order(created_at: :desc)
  end

  def new
    render layout: 'guest'
  end

  def create
    if (identity = Identity.authenticate_by(email: params[:email], password: params[:password]))
      Current.person = identity.users.first || identity.clients.first
      Current.account = Current.person.account

      @session = identity.sessions.create!
      cookies.signed.permanent[:session_token] = { value: @session.id, httponly: true }

      redirect_to root_path, notice: t('.signed_in_successfully')
    else
      redirect_to sign_in_path(email_hint: params[:email]), alert: t('.that_email_or_password_is_incorrect')
    end
  end

  def destroy
    @session.destroy
    redirect_to(sessions_path, notice: t('.that_session_has_been_logged_out'))
  end

  private

  def set_session
    @session = Current.identity.sessions.find(params[:id])
  end
end
