# frozen_string_literal: true

class Criterium < ApplicationRecord
  include Status

  belongs_to :parent, class_name: 'Criterium', optional: true, inverse_of: :children
  has_many :children, class_name: 'Criterium', foreign_key: :parent_id, dependent: :destroy, inverse_of: :parent

  enum year: {
    year_2021: 2021,
    year_2022: 2022,
    year_2023: 2023,
    year_2024: 2024,
    year_2025: 2025,
    year_2026: 2026
  }

  enum level: {
    node_roots: 0,
    node_groups: 1,
    node_subs: 2,
    node_leaves: 3
  }

  # enum product_group: {
  #   group1: 'group1',
  #   group2: 'group2',
  #   group3: 'group3'
  # }

  scope :of_year, ->(year) { where year: }
  scope :of_group, ->(group) { where product_group: group }
  scope :for_submission, lambda { |submission|
                           where(product_group: submission.product_group).where(year: submission.year)
                         }
end
