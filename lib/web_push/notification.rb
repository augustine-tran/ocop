# frozen_string_literal: true

class WebPush::Notification
  def initialize(title:, body:, path:, badge:, endpoint:, p256dh_key:, auth_key:) # rubocop:disable Metrics/ParameterLists
    @title = title
    @body = body
    @path = path
    @badge = badge
    @endpoint = endpoint
    @p256dh_key = p256dh_key
    @auth_key = auth_key
  end

  def deliver(connection: nil)
    WebPush.payload_send \
      message: encoded_message,
      endpoint: @endpoint, p256dh: @p256dh_key, auth: @auth_key,
      vapid: vapid_identification,
      connection:,
      urgency: 'high'
  end

  private

  def vapid_identification
    { subject: 'mailto:support@37signals.com' }.merge \
      Rails.configuration.x.vapid.symbolize_keys
  end

  def encoded_message
    JSON.generate title: @title, options: { body: @body, data: { path: @path, badge: @badge } }
  end

  def icon_path
    Current.account.avatar_url(200)
  end
end
