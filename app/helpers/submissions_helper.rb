# frozen_string_literal: true

module SubmissionsHelper
  def companies_collection
    Current.person.companies
  end

  def judge_selected_for(criterium_id, assessment)
    assessment.scores.find_by(criterium_id:)&.criterion
  end

  def submission_tab_options(submission, _assessment = nil)
    list_options = []

    if Current.person.can? :edit,
                           submission
      list_options << create_option(t(:submission), submission_url(submission))
    end

    if Current.person.can? :judge,
                           submission
      list_options << create_option(t(:submission_name, name: submission.name),
                                    panel_submission_url(submission))
    end

    if Current.person.can? :approve,
                           submission.self_assessment
      list_options << create_option(t(:submission_name, name: submission.name),
                                    assistant_submission_url(submission))
      list_options << create_option(t(:approve_self_assessment),
                                    assistant_submission_assessment_url(submission, submission.self_assessment))
    end

    list_options << if submission.self_assessment.can_submit?
                      create_option(t(:self_assessment),
                                    edit_assessment_url(submission.self_assessment))
                    else
                      create_option(t(:self_assessment),
                                    assessment_url(submission.self_assessment))
                    end

    if Current.person.can?(:judge, submission) && submission.panel_assessments.any?
      list_options << create_option(t(:do_assessment), edit_assessment_url(submission.assessment_for(Current.person)))
      list_options << create_option(t(:final_assessment),
                                    final_assessment_url(submission.final_assessment))
    end

    if Current.person.can?(:approve, submission.self_assessment) && submission.final_assessment.present?
      list_options << create_option(t(:final_assessment),
                                    final_assessment_url(submission.final_assessment))
    end

    list_options
  end
end
