# frozen_string_literal: true

class CreatePanelAssessmentsJob < ApplicationJob
  queue_as :default

  def perform(submission)
    Current.set account: submission.account.administrator do
      Council.find_by(councilable_type: 'OcopCouncil').members.each do |judge|
        submission.assessments.create! judge: judge.person, assessable: if judge.president?
                                                                          FinalAssessment.new
                                                                        else
                                                                          PanelAssessment.new
                                                                        end
      end
    end
  end
end
