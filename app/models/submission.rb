# frozen_string_literal: true

class Submission < ApplicationRecord
  include Scorable, Status, AccountScoped

  attr_accessor :year

  after_initialize :set_year

  enum product_group: {
    group1: 'group1',
    group2: 'group2'
  }

  belongs_to :company, optional: false, touch: true
  has_many_attached :photos do |attachable|
    attachable.variant :thumb, resize_to_limit: [150, nil]
  end
  has_rich_text :description

  after_create :create_scores_according_to_criteria

  broadcasts_refreshes

  def update_scores_sum
    update_columns(scores_sum: scores.node_roots.sum(:score)) if scores_sum != scores.sum(:score) # rubocop:disable Rails/SkipsModelValidations
  end

  private

  def set_year
    self.year ||= created_at&.year || Time.zone.today.year
  end

  def create_scores_according_to_criteria
    Criterium.for_submission(self).node_roots.each do |root_criterium|
      create_scores(root_criterium, nil)
    end
  end

  def create_scores(criterium, parent_score)
    # Skip if criterium is leaf (level 3)
    return if criterium.children.blank?

    new_score = scores.create(criterium:, parent: parent_score, level: criterium.level)
    criterium.children.each do |child_criterium|
      create_scores(child_criterium, new_score)
    end
  end
end
