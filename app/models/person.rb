# frozen_string_literal: true

class Person < ApplicationRecord
  belongs_to :account

  delegated_type :personable, types: Personable::TYPES

  delegate :name, :email, :role, to: :personable

  delegate :can?, :cannot?, to: :ability

  def ability
    @ability ||= Ability.new(self)
  end
end
