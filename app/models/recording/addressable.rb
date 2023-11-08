# frozen_string_literal: true

module Recording::Addressable
  extend ActiveSupport::Concern

  delegate :addresses, to: :children
end
