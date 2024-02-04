# frozen_string_literal: true

class Submission < ApplicationRecord
  include Status

  attr_accessor :year

  after_initialize :set_year

  enum round: {
    self: 'self',
    district: 'district',
    province: 'province'
  }

  enum product_group: {
    group1: 'group1',
    group2: 'group2'
  }

  belongs_to :account
  has_many :assessments, dependent: :destroy
  has_one :self_assessment, lambda {
                              where assessable_type: 'SelfAssessment'
                            }, class_name: 'Assessment', dependent: :destroy
  has_many :panel_assessments, through: :assessements, source: :assessable, source_type: 'PanelAssessment'

  has_many_attached :photos do |attachable|
    attachable.variant :thumb, resize_to_limit: [150, nil]
  end
  has_rich_text :description

  broadcasts_refreshes

  after_create :create_self_assessment

  def finish_self_assessment
    Rails.logger.debug '--> finish_self_assessment'
    CreatePanelAssessmentsJob.perform_later self
  end

  private

  def set_year
    self.year ||= created_at&.year || Time.zone.today.year
  end

  def create_self_assessment
    CreateSelfAssessmentJob.perform_now self
  end
end
