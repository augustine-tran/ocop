# frozen_string_literal: true

class CreateSelfAssessmentJob < ApplicationJob
  queue_as :default

  def perform(submission)
    Current.set person: submission.account.people.first! do
      submission.assessments.create! assessable: SelfAssessment.new, judge: submission.creator
    end
  end
end
