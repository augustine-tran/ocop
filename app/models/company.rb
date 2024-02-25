# frozen_string_literal: true

class Company < ApplicationRecord
  include AccountScoped
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

  after_create :set_user_company, if: -> { Current.person&.user? }

  private

  def set_user_company
    Current.person.personable.update company: self
    Current.person.reload
  end
end
