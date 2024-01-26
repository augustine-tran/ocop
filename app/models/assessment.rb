# frozen_string_literal: true

class Assessment < ApplicationRecord
  belongs_to :criterium
  belongs_to :score
  belongs_to :judge, class_name: 'Person'

  enum round: {
    self: 'self',
    district: 'district',
    province: 'province'
  }
end
