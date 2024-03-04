# frozen_string_literal: true

class CreateFinalAssesmentJob < ApplicationJob
  queue_as :default

  def perform(submission)
    Current.set account: submission.account do
      submission.assessments.create! assessable: FinalAssessment.new, judge: submission.council.president
    end
  end
end
