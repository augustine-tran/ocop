# frozen_string_literal: true

module Recording::Produceable
  extend ActiveSupport::Concern

  delegate :products, to: :children
end
