# frozen_string_literal: true

class Current < ActiveSupport::CurrentAttributes
  attribute :session
  attribute :user_agent, :ip_address

  attribute :account, :person

  delegate :identity, to: :session, allow_nil: true
end
