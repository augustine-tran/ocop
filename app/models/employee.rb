# frozen_string_literal: true

class Employee < ApplicationRecord
  include Status, AccountScoped

  belongs_to :company, optional: false, touch: true
  belongs_to :manager, class_name: 'Employee', optional: true, dependent: :destroy, inverse_of: :reporters
  has_many :reporters, through: :manager, class_name: 'Employee', inverse_of: :manager

  def no_manager?
    manager.nil?
  end
end
