# frozen_string_literal: true

class Employee < ApplicationRecord
  include Recordable

  belongs_to :manager, class_name: 'Recording', optional: true, dependent: :destroy

  def no_manager?
    manager.nil?
  end
end
