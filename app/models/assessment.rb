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

    scores.of_stars(rank).each do |s|
      list << { id: s.criterium_id, title: s.title, min_score: s.min_score_of_rank(rank), check: s.pass_rank?(rank),
                score: s.score }
    end

    list.sort_by { |criterium| criterium[:check] ? 1 : 0 }
  end

  def rank_require_stats(rank)
    list = rank_requires(rank)
    { total: list.size, passed: list.count { |criterium| criterium[:check] } }
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

  # return absolute difference between scores
  def scores_diff(assessment)
    (scores_sum - assessment.scores_sum).abs
  end

  private

  def status_previously_changed_to_active?
    status_previously_changed? && active?
  end

  def compare_scores(criteria, scores_hash)
    criteria.map do |id, title, score|
      { id:, title:, min_score: score, check: scores_hash[id] >= (score || 0), score: scores_hash[id] }
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
