# frozen_string_literal: true

module Councilable
  extend ActiveSupport::Concern

  TYPES = %w[OcopCouncil].freeze

  included do
    has_one :council, as: :councilable, dependent: :destroy
  end
end
