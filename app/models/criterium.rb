# frozen_string_literal: true

class Criterium < ApplicationRecord
  belongs_to :parent, class_name: 'Criterium', touch: true, optional: true, inverse_of: :children
  has_many :children, class_name: 'Criterium', foreign_key: :parent_id, dependent: :destroy, inverse_of: :parent

  enum year: {
    year_2021: 2021,
    year_2022: 2022,
    year_2023: 2023,
    year_2024: 2024,
    year_2025: 2025,
    year_2026: 2026
  }

  scope :of_year, ->(year) { where year: }
end
