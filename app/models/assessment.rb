# frozen_string_literal: true

class Assessment < ApplicationRecord
  include Scorable, Status

  belongs_to :submission
  delegated_type :assessable, types: Assessable::TYPES

  delegate :year, :product_group, :name, :account, to: :submission
end
