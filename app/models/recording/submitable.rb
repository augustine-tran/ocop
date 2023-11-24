# frozen_string_literal: true

module Recording::Submitable
  extend ActiveSupport::Concern

  delegate :submissions, to: :children
end
