# frozen_string_literal: true

module Scorable
  extend ActiveSupport::Concern

  included do
    has_many :scores, as: :scorable, dependent: :destroy
    has_many :criteria, through: :scores
  end
end
