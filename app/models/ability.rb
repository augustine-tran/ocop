# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(person)
    personable = person.personable

    return if person.blank?

    if person.user?
      if personable.admin?
        can :manage, :all
      elsif personable.editor?
        can :manage, Company, account_id: person.account_id, company: personable.company
        can :manage, Submission, account_id: person.account_id, company: personable.company
      else
        can :read, :all
      end
    end

    return unless person.client?

    can :manage, Submission, account_id: person.account_id, company: personable.company
  end
end
