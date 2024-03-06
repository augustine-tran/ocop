# frozen_string_literal: true

class Identity < ApplicationRecord
  has_secure_password

  generates_token_for :email_verification, expires_in: 2.days { email }
  generates_token_for :password_reset, expires_in: 20.minutes { password_salt.last(10) }

  has_many :sessions, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :judges, dependent: :destroy
  has_many :assistants, dependent: :destroy

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, allow_nil: false, length: { minimum: 6 }

  normalizes :email, with: -> { _1.strip.downcase }

  before_validation if: :email_changed?, on: :update do
    self.verified = false
  end

  after_update if: :password_digest_previously_changed? do
    sessions.where.not(id: Current.session).delete_all
  end
end
