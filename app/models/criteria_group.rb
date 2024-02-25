# frozen_string_literal: true

class CriteriaGroup < ApplicationRecord
  belongs_to :criteria_bucket
  has_many :criteria, dependent: :destroy
end
