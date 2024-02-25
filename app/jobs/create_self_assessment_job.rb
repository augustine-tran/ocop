# frozen_string_literal: true

class CreateSelfAssessmentJob < ApplicationJob
  queue_as :default

  def perform(submission)
    submission.assessments.create! assessable: SelfAssessment.new, judge: submission.creator
  end
end
