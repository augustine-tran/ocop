# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_current_request_details
  before_action :authenticate
  before_action :set_layout_base_on_account_type

  protected

  def current_ability
    @current_ability ||= Ability.new(Current.person)
  end

  def current_session
    @current_session ||= Current.session
  end
  helper_method :current_session

  private

  def set_layout_base_on_account_type
    layout = Current.account&.accountable.is_a?(DistrictDepartment) ? 'admin' : 'application'
    Rails.logger.info "Setting layout to #{layout}"
    Rails.logger.info "Current.account: #{Current.account.inspect}"
    self.class.layout(layout)
  end

  def authenticate
    if (session_record = Session.find_by(id: cookies.signed[:session_token]))
      Current.session = session_record
      Current.person = (Current.session.identity.users.first || Current.session.identity.clients.first)&.person
      Current.account = Current.person.account
    else
      redirect_to sign_in_path
    end
  end

  def set_current_request_details
    Current.user_agent = request.user_agent
    Current.ip_address = request.ip
  end
end
