# frozen_string_literal: true

class Current < ActiveSupport::CurrentAttributes
  attribute :session
  attribute :user_agent, :ip_address

  attribute :person

  delegate :identity, to: :session, allow_nil: true
  delegate :ability, to: :person

  def account
    Account.first
  end
end
