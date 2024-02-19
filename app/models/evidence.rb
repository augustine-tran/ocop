# frozen_string_literal: true

class Evidence < ApplicationRecord
  belongs_to :criterium
  belongs_to :score, touch: true

  before_create :set_criterium

  has_many_attached :files do |attachable|
    attachable.variant :thumb, resize_to_limit: [150, nil]
    attachable.variant :large, resize_to_limit: [960, nil]
  end

  has_rich_text :story

  private

  def set_criterium
    self.criterium_id = score.criterium_id
  end
end
