# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(person)
    return if person.blank?

    can :read, :all
    can :create, Submission, :all

    can(:view, Submission) { |submission| included_in_submissions?(person, submission) }
    can(:judge, Submission) { |submission| included_in_panel_submissions?(person, submission) }
    can(:final, Submission) { |submission| included_in_final_submissions?(person, submission) }
    can(:manage, Evidence) { |evidence| creator?(person, evidence.submission) || person.assistant? && evidence.submission.council.people.include?(person) }
    can :edit, Assessment, judge_id: person.id, assessable_type: :PanelAssessment
    can :edit, Assessment, judge_id: person.id, assessable_type: :FinalAssessment
    can(:approve, Assessment) { |assessment| person.assistant? && assessment.submission.council.people.include?(person) }

    can :view, Submission do |submission|
      creator?(person, submission) || included_in_submissions?(person, submission)
    end
    can :edit, Submission, creator: person
    can :destroy, Submission, account_id: person.account_id
  end

  private

  def creator?(person, submission)
    submission.creator == person
  end

  def included_in_submissions?(person, submission)
    person.panel_submissions.include?(submission) || person.final_submissions.include?(submission)
  end

  def included_in_panel_submissions?(person, submission)
    person.panel_submissions.include?(submission)
  end

  def included_in_final_submissions?(person, submission)
    person.final_submissions.include?(submission)
  end
end
