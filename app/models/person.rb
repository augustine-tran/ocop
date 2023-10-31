# frozen_string_literal: true

class Person < ApplicationRecord
  include AccountScoped

  delegated_type :personable, types: Personable::TYPES

  delegate :name, :email, to: :personable
end
