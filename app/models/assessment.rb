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
    list = []
    list << { title: 'Đủ điều kiện 4 sao', check: pass_rank?(4) } if rank == 5
    list << { title: 'Đủ điều kiện 3 sao', check: pass_rank?(3) } if rank == 4
    list << compare_scores_sum(rank)

    criteria = criteria_requires_for rank
    list.concat compare_scores(criteria, current_scores(criteria))

    list
  end

  def pass_rank?(rank)
    check_list = rank_requires(rank)
    check_list.any? && check_list.all? { |criterium| criterium[:check] }
  end

  def max_rank
    return 5 if pass_rank? 5
    return 4 if pass_rank? 4
    return 3 if pass_rank? 3

    0
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
      { id:, title:, min_score: score, check: scores_hash[id] >= score, score: scores_hash[id] }
    end
  end

  def compare_scores_sum(rank)
    min_score = case rank
                when 3
                  50
                when 4
                  70
                when 5
                  90
                else
                  0
                end

    { title: "(Hạng #{rank} sao) Yêu cầu tổng điểm phải lớn hơn #{min_score}", min_score:,
      check: scores_sum >= min_score, score: scores_sum }
  end
end
