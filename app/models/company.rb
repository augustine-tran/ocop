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

  before_validation :set_owner, if: :new_record?

  validates :registration_no, uniqueness: true, if: :registration_no?
  validates :name, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[name]
  end

  private

  def set_owner
    self.owner = Current.person
  end
end
