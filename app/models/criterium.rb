# frozen_string_literal: true

class Criterium < ApplicationRecord
  include Status

  belongs_to :criteria_group, optional: true

  belongs_to :parent, class_name: 'Criterium', optional: true, inverse_of: :children
  has_many :children, class_name: 'Criterium', foreign_key: :parent_id, dependent: :destroy, inverse_of: :parent
  scope :for_submission, ->(submission) { where(criteria_group: submission.criteria_group) }

  has_many :scores, dependent: :destroy
  has_many :evidences, through: :scores

  broadcasts_refreshes

  enum level: {
    node_roots: 0,
    node_groups: 1,
    node_subs: 2,
    node_leaves: 3
  }

  scope :of_stars, ->(stars) { where("star_#{stars} > ?", 0).order(:id) }
end
