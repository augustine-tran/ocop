# frozen_string_literal: true

class Submission < ApplicationRecord
  include AccountScoped, Status
  include Rankable

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

  scope :except_drafted, -> { where.not status: :drafted }

  broadcasts_refreshes

  before_validation :set_creator, if: -> { new_record? && creator.blank? }

  validates :name, presence: true

  after_create :create_self_assessment

  def finish_self_assessment
    Rails.logger.debug '--> finish_self_assessment'
    set_status_active
    create_panel_assessments
    create_final_assessment
  end

  def finish_panel_assessment(assessment)
    Rails.logger.debug { "--> finish_panel_assessment #{assessment.inspect}" }
    final_assessment.assessable.update_scores_from_panel_assessments
  end

  def finish_final_assessment
    update status: :archived, star: final_assessment.star, scores_sum: final_assessment.scores_sum
  end

  def unfinish_panel_assessments_count
    panel_assessments.drafted.count
  end

  def assessment_for(judge)
    panel_assessments.find_by(judge:) || final_assessment&.find_by(judge:)
  end

  def self.ransackable_attributes(_auth_object)
    %w[name status star]
  end

  private

  def set_creator
    self.creator ||= Current.person
  end

  def create_self_assessment
    CreateSelfAssessmentJob.perform_now self
  end

  def set_status_active
    update status: :active
  end

  def create_panel_assessments
    CreatePanelAssessmentsJob.perform_later self
  end

  def create_final_assessment
    CreateFinalAssesmentJob.perform_later self
  end
end
