# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(person)
    return if person.blank?

    can :read, :all

    can :manage, Submission, account_id: person.account_id if person.editor?

    return unless person.admin?

    can :manage, Company, account_id: person.account_id
    can :manage, Submission, account_id: person.account_id
  end
end
