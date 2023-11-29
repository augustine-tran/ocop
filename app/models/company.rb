# frozen_string_literal: true

class Company < ApplicationRecord
  include Addressable, AccountScoped, Status

  enum legal_type: {
    pc: 'pc',
    llc: 'llc',
    js: 'joined-stock',
    htx: 'htx'
  }

  has_one :director, -> { where(manager: nil) }, class_name: 'Employee', dependent: :destroy
  has_many :employees, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :submissions, through: :products, dependent: :destroy
end
