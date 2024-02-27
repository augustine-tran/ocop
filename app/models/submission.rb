# frozen_string_literal: true

class Submission < ApplicationRecord
  include AccountScoped, Status

  belongs_to :creator, class_name: 'Person'
  belongs_to :company

  belongs_to :council
  belongs_to :criteria_group

  has_many :assessments, dependent: :destroy
  has_one :self_assessment, lambda {
                              where assessable_type: 'SelfAssessment'
                            }, class_name: 'Assessment', dependent: :destroy
  has_one :final_assessment, lambda {
                               where assessable_type: 'FinalAssessment'
                             }, class_name: 'Assessment', dependent: :destroy

  has_many :panel_assessments, lambda {
                                 where assessable_type: 'PanelAssessment'
                               }, class_name: 'Assessment', dependent: :destroy

  has_many_attached :files do |attachable|
    attachable.variant :thumb, resize_to_limit: [150, nil]
    attachable.variant :large, resize_to_limit: [920, nil]
  end
  has_rich_text :description

  broadcasts_refreshes

  before_validation :set_creator, if: -> { new_record? && creator.blank? }

  validates :name, presence: true

  after_create :create_self_assessment

  def finish_self_assessment
    Rails.logger.debug '--> finish_self_assessment'
    CreatePanelAssessmentsJob.perform_later self
  end

  def finish_panel_assessment(assessment)
    Rails.logger.debug { "--> finish_panel_assessment #{assessment.inspect}" }
    final_assessment.update scores_sum: panel_assessments.active.average(:scores_sum)
  end

  def finish_final_assessment
    update status: :archived
  end

  def unfinish_panel_assessments_count
    panel_assessments.drafted.count
  end

  def assessment_for(judge)
    panel_assessments.find_by(judge:) || final_assessment&.find_by(judge:)
  end

  private

  def set_creator
    self.creator ||= Current.person
  end

  def create_self_assessment
    CreateSelfAssessmentJob.perform_now self
  end
end
