# frozen_string_literal: true

module Scorable
  extend ActiveSupport::Concern

  included do
    has_many :scores, dependent: :destroy
    has_many :criteria, through: :scores
    has_many :evidences, through: :scores

    after_create :create_scores_according_to_criteria

    broadcasts_refreshes

    def update_scores_sum
      update_columns(scores_sum: scores.node_roots.sum(:score)) if scores_sum != scores.sum(:score) # rubocop:disable Rails/SkipsModelValidations
    end

    def scored_all?
      scores.node_subs.where(criterion: nil).count.zero?
    end

    private

    def create_scores_according_to_criteria
      Criterium.for_submission(submission).node_roots.each do |root_criterium|
        create_scores(root_criterium, nil)
      end
    end

    def create_scores(criterium, parent_score)
      # Skip if criterium is leaf (level 3)
      return if criterium.children.blank?

      new_score = scores.create(criterium:, parent: parent_score,
                                title: criterium.title, description: criterium.description,
                                level: criterium.level, stars: criterium.stars,
                                star_3: criterium.star_3, star_4: criterium.star_4, star_5: criterium.star_5)

      criterium.children.each do |child_criterium|
        create_scores(child_criterium, new_score)
      end
    end
  end
end
