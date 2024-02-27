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

  belongs_to :owner, class_name: 'Person'

  validates :registration_no, uniqueness: true, if: :registration_no?

  before_validation :set_owner, if: :new_record?

  private

  def set_owner
    self.owner = Current.person
  end
end
