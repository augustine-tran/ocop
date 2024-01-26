# frozen_string_literal: true

class Person < ApplicationRecord
  belongs_to :account

  delegated_type :personable, types: Personable::TYPES

  delegate :name, :email, :role, to: :personable

  delegate :can?, :cannot?, to: :ability

  has_one :council_member, dependent: :destroy

  has_many :accounts, through: :council_members

  enum role: {
    admin: 'admin',
    head_judge: 'head_jugde',
    judge: 'jugde',
    user: 'user'
  }

  def ability
    @ability ||= Ability.new(self)
  end

  def president?
    self == Current.account.president
  end
end
