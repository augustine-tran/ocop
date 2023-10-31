# frozen_string_literal: true

class Person < ApplicationRecord
  belongs_to :account

  delegated_type :personable, types: Personable::TYPES

  delegate :name, :email, to: :personable
end
