# frozen_string_literal: true

module Authentication
  extend ActiveSupport::Concern
  include SessionLookup

  included do
    before_action :require_authentication
    helper_method :signed_in?
  end

  class_methods do
    def allow_unauthenticated_access(**options)
      skip_before_action :require_authentication, **options
    end

    def require_unauthenticated_access(**options)
      skip_before_action :require_authentication, **options
      before_action :restore_authentication, :redirect_signed_in_user_to_root, **options
    end
  end

  private

  def require_authentication
    restore_authentication || request_authentication
  end

  def restore_authentication
    return unless (session = find_session_by_cookie)

    resume_session session
  end

  def request_authentication
    session[:return_to_after_authenticating] = request.url
    redirect_to sign_in_path
  end

  def redirect_signed_in_user_to_root
    redirect_to root_url if signed_in?
  end

  def signed_in?
    Current.person.present?
  end

  def start_new_session_for(identity)
    identity.sessions.start!(user_agent: request.user_agent, ip_address: request.remote_ip).tap do |session|
      authenticated_as session
    end
  end

  def resume_session(session)
    session.resume user_agent: request.user_agent, ip_address: request.remote_ip
    authenticated_as session
  end

  def authenticated_as(session)
    Current.session = session
    Current.person = (Current.session.identity.users.first || Current.session.identity.judges.first || Current.session.identity.assistants.first)&.person
    Current.account = Current.person.account

    cookies.signed.permanent[:session_token] = { value: session.token, httponly: true, same_site: :lax }
  end

  def post_authenticating_url
    session.delete(:return_to_after_authenticating) || root_url
  end

  def reset_authentication
    cookies.delete(:session_token)
  end
end
