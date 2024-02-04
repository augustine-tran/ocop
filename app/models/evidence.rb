# frozen_string_literal: true

class Evidence < ApplicationRecord
  belongs_to :criterium
  belongs_to :score, touch: true

  before_create :set_criterium

  has_many_attached :files

  has_rich_text :story

  private

  def set_criterium
    self.criterium_id = score.criterium_id
  end
end
