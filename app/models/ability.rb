# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(person)
    return if person.blank?

    can :read, :all

    return unless person.admin?

    can :manage, Company
    can :manage, Submission, account_id: person.account_id
  end
end
