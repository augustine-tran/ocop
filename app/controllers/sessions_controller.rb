# frozen_string_literal: true

class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[new create]

  def index
    @sessions = Current.identity.sessions.order(created_at: :desc)
  end

  def new
    render layout: 'guest'
  end

  def create
    if (identity = Identity.authenticate_by(email: params[:email], password: params[:password]))
      start_new_session_for identity
      redirect_to post_authenticating_url
    else
      render_rejection :unauthorized
    end
  end

  def destroy
    remove_push_subscription
    reset_authentication
    redirect_to root_url
  end

  private

  def render_rejection(status)
    flash.now[:alert] = '⛔️' # rubocop:disable Rails/I18nLocaleTexts
    render :new, layout: 'guest', status:
  end

  def remove_push_subscription
    return unless endpoint = params[:push_subscription_endpoint]

    Push::Subscription.destroy_by(endpoint:, user_id: Current.user.id)
  end
end
