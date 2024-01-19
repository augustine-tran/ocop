# frozen_string_literal: true

module Accountable
  extend ActiveSupport::Concern

  TYPES = %w[Company DistrictDepartment].freeze

  included do
    has_one :account, as: :accountable, touch: true, dependent: :destroy

    delegate_missing_to :account
  end
end
