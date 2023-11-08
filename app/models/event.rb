# frozen_string_literal: true

class Event < ApplicationRecord
  PUBLICATION_ACTIONS = %w[active created].freeze

  belongs_to :recording
  belongs_to :creator, class_name: 'Person', default: -> { Current.person }

  has_one :detail, dependent: :destroy

  delegated_type :recordable, types: Recordable::TYPES
  delegated_type :recordable_previous, types: Recordable::TYPES, required: false

  scope :chronologically, -> { order 'created_at asc, id desc' }
  scope :reverse_chronologically, -> { order 'created at desc, id desc' }
end
