# frozen_string_literal: true

module Assessable
  extend ActiveSupport::Concern

  TYPES = %w[PanelAssessment SelfAssessment FinalAssessment].freeze

  included do
    has_one :assessment, as: :assessable, touch: true, dependent: :destroy

    delegate :submission, :judge, :scores_sum, :status, :photos, :description, to: :assessment
  end
end
