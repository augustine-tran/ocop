# frozen_string_literal: true

class Session < ApplicationRecord
  ACTIVITY_REFRESH_RATE = 1.hour

  has_secure_token

  belongs_to :identity

  scope :inactive, -> { where('last_active_at < ?', INACTIVE_AFTER.ago) }

  before_create { self.last_active_at ||= Time.zone.now }

  def self.start!(user_agent:, ip_address:)
    create! user_agent:, ip_address:
  end

  def resume(user_agent:, ip_address:)
    return unless last_active_at.before?(ACTIVITY_REFRESH_RATE.ago)

    update! user_agent:, ip_address:, last_active_at: Time.zone.now
  end
end
