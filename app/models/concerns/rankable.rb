# frozen_string_literal: true

module Rankable
  extend ActiveSupport::Concern

  included do
    def suggested_stars
      case scores_sum
      when 0..19
        1
      when 20..49
        2
      when 50..59
        3
      when 60..79
        4
      when 80..100
        5
      end
    end
  end
end
