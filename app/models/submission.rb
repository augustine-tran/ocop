# frozen_string_literal: true

class Submission < ApplicationRecord
  include Scorable, Status, AccountScoped

  attr_accessor :year

  after_initialize :set_year

  enum product_group: {
    group1: 'group1',
    group2: 'group2'
  }

  belongs_to :product, optional: false, touch: true
  has_many_attached :photos do |attachable|
    attachable.variant :thumb, resize_to_limit: [150, nil]
  end
  has_rich_text :description

  after_create :create_scores

  private

  def set_year
    self.year ||= created_at&.year || Time.zone.today.year
  end

  def create_scores
    Criterium.for_submission(self).node_sub.each do |criterium|
      scores.create! criterium:, score: 0
    end
  end
end
