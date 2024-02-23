# frozen_string_literal: true

module Personable
  extend ActiveSupport::Concern

  TYPES = %w[User Judge Tombstone].freeze

  included do
    has_one :person, as: :personable, touch: true, dependent: :destroy

    delegate :account, to: :person
  end
end
