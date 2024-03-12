# frozen_string_literal: true

class Assessment < ApplicationRecord
  include Scorable, Status
  include Rankable

  belongs_to :submission
  delegated_type :assessable, types: Assessable::TYPES
  belongs_to :judge, class_name: 'Person', optional: true

  delegate :company, :year, :criteria_group, :name, :account, :files, :description, to: :submission
  delegate :can_submit?, to: :assessable

  after_save :notify_submission, if: :status_previously_changed_to_active?

  delegate :submit, :notify_submission, to: :assessable

  def can_approve?
    assessable.is_a?(SelfAssessment) && approval?
  end

  def approve
    return unless can_approve?

    transaction do
      update(status: :active)
      submission.update(status: :active)
    end
  end

  def rank_requires(rank)
    criteria = criteria_requires_for(rank)
    compare_scores criteria, current_scores(criteria)
  end

  def pass_rank?(rank)
    check_list = rank_requires(rank)
    check_list.any? && check_list.all? { |criterium| criterium[:check] }
  end

  private

  def status_previously_changed_to_active?
    status_previously_changed? && active?
  end

  def criteria_requires_for(rank)
    criteria_group.criteria.of_stars(rank).pluck(:id, :title, :score)
  end

  def current_scores(criteria)
    list = scores.where(criterium_id: criteria.map(&:first)).pluck(:id, :criterium_id, :score)
    list.each_with_object({}) { |(_id, criterium_id, score), hash| hash[criterium_id] = score || 0 }
  end

  def compare_scores(criteria, scores_hash)
    criteria.map do |id, title, score|
      { id:, title:, required_score: score, check: scores_hash[id] >= score, score: scores_hash[id] }
    end
  end
end
