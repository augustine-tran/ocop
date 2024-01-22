# frozen_string_literal: true

class Company < ApplicationRecord
  include Accountable
  include Addressable, Status

  enum legal_type: {
    pc: 'pc',
    llc: 'llc',
    js: 'joined-stock',
    htx: 'htx'
  }

  has_one :director, -> { where(manager: nil) }, class_name: 'Employee', dependent: :destroy
  has_many :employees, dependent: :destroy
  has_many :clients, dependent: :destroy

  validates :registration_no, uniqueness: true, if: :registration_no?
end
