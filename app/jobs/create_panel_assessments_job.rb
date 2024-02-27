# frozen_string_literal: true

class CreatePanelAssessmentsJob < ApplicationJob
  queue_as :default

  def perform(submission)
    Current.set account: submission.account do
      Current.account.councils.find(submission.council_id).members.each do |judge|
        submission.assessments.create! judge: judge.person, assessable: if judge.president?
                                                                          FinalAssessment.new
                                                                        else
                                                                          PanelAssessment.new
                                                                        end
      end
    end
  end
end
