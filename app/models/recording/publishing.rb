# frozen_string_literal: true

module Recording::Publishing
  extend ActiveSupport::Concern

  delegate :publishings, to: :children
end
