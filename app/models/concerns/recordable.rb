# frozen_string_literal: true

module Recordable
  extend ActiveSupport::Concern

  TYPES = %w[Company Address Employee Criterium].freeze

  included do
    has_one :recording, as: :recordable, touch: true, dependent: :destroy
  end
end
