# frozen_string_literal: true

class Score < ApplicationRecord
  include AccountScoped

  belongs_to :scorable, polymorphic: true, optional: false, touch: true
  belongs_to :criterium, dependent: :destroy, optional: false
  belongs_to :criterion, class_name: 'Criterium', optional: true
  belongs_to :parent, class_name: 'Score', optional: true, touch: true
  has_many :children, class_name: 'Score', foreign_key: :parent_id, dependent: :destroy

  delegate :level, :title, :description, to: :criterium

  before_validation :set_score
  after_save :recalibrate_score, if: -> { saved_change_to_score? }

  enum level: {
    node_roots: 0,
    node_groups: 1,
    node_subs: 2,
    node_leaves: 3
  }

  def recalibrate_score
    if children.present?
      new_score = children.sum(:score)
      # Use update_columns to skip callbacks and prevent infinite loop
      update_columns(score: new_score) if score != new_score # rubocop:disable Rails/SkipsModelValidations
    end

    parent.recalibrate_score if parent.present?
  end

  private

  def set_score
    self.score = criterion&.score || 0 if criterion&.node_leaves?
  end
end
