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

  belongs_to :administrator, class_name: 'Person'
  has_many :owners, class_name: 'Company::Owner', dependent: :destroy, inverse_of: :company

  before_validation :set_administrator, if: :new_record?

  validates :registration_no, uniqueness: true, if: :registration_no?
  validates :name, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[name]
  end

  private

  def set_administrator
    self.administrator = Current.person
  end
end
