# frozen_string_literal: true

class CreatePanelAssessmentsJob < ApplicationJob
  queue_as :default

  def perform(submission)
    Current.set account: submission.account do
      submission.council.members.each do |judge|
        next if judge.assistant?

        submission.assessments.create! judge: judge.person, assessable: PanelAssessment.new
      end
    end
  end
end
