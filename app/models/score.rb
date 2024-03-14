# frozen_string_literal: true

class Score < ApplicationRecord
  belongs_to :assessment, optional: false, touch: true
  belongs_to :criterium, optional: false
  belongs_to :criterion, class_name: 'Criterium', optional: true
  belongs_to :parent, class_name: 'Score', optional: true, touch: true
  has_many :children, class_name: 'Score', foreign_key: :parent_id, dependent: :destroy
  has_one :evidence, dependent: :destroy

  before_validation :set_score
  after_save :recalibrate_score, if: -> { saved_change_to_score? }

  enum level: {
    node_roots: 0,
    node_groups: 1,
    node_subs: 2,
    node_leaves: 3
  }

  scope :of_stars, ->(stars) { where("star_#{stars} > ?", 0).order(:id) }

  def pass_rank?(rank)
    min_score_of_rank(rank) <= (score || 0)
  end

  def min_score_of_rank(rank)
    min_score = case rank
                when 5
                  star_5
                when 4
                  star_4
                when 3
                  star_3
                end

    min_score || 0
  end

  def recalibrate_score
    if children.present?
      new_score = children.sum(:score)
      # Use update_columns to skip callbacks and prevent infinite loop
      update_columns(score: new_score) if score != new_score # rubocop:disable Rails/SkipsModelValidations
    end

    parent.recalibrate_score if parent.present?

    assessment.update_scores_sum if parent.blank?
  end

  private

  def set_score
    self.score = criterion&.score || 0 if criterion&.node_leaves?
  end
end
