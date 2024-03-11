# frozen_string_literal: true

class CreateFinalAssesmentJob < ApplicationJob
  queue_as :default

  def perform(submission)
    Current.set person: submission.account.people.first! do
      submission.assessments.create! assessable: FinalAssessment.new, judge: submission.council.president
    end
  end
end
