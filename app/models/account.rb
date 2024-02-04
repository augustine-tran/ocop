# frozen_string_literal: true

class Account < ApplicationRecord
  delegated_type :accountable, types: Accountable::TYPES

  belongs_to :administrator, class_name: 'Account', optional: true
  belongs_to :district, class_name: 'AdministrativeUnit', optional: true
  belongs_to :province, class_name: 'AdministrativeUnit', optional: true

  has_many :submissions, dependent: :destroy
  has_many :assessments, through: :submissions

  has_many :people, dependent: :destroy
  has_many :managed_accounts, class_name: 'Account', foreign_key: :administrator_id, dependent: :nullify
  has_many :managed_submissions, through: :managed_accounts, source: :submissions

  has_many :councils, dependent: :destroy

  def province
    province || administrator&.province
  end

  def district
    province || administrator&.province
  end
end
