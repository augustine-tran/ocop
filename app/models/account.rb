# frozen_string_literal: true

require 'letter_avatar/has_avatar'

class Account < ApplicationRecord
  include LetterAvatar::HasAvatar

  belongs_to :district, class_name: 'AdministrativeUnit', optional: true
  belongs_to :province, class_name: 'AdministrativeUnit', optional: true

  has_many :companies, dependent: :destroy
  has_many :submissions, dependent: :destroy
  has_many :assessments, through: :submissions

  has_many :people, dependent: :destroy
  has_many :managed_accounts, class_name: 'Account', foreign_key: :administrator_id, dependent: :nullify
  has_many :managed_submissions, through: :managed_accounts, source: :submissions

  has_many :criteria_buckets, dependent: :destroy
  has_many :councils, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :posts, dependent: :destroy

  def province
    province || administrator&.province
  end

  def district
    province || administrator&.province
  end
end
