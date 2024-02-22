# frozen_string_literal: true

class Push::Subscription < ApplicationRecord
  belongs_to :person

  def notification(**params)
    WebPush::Notification.new(**params, badge: 9, endpoint:,
                                        p256dh_key:, auth_key:)
  end
end
