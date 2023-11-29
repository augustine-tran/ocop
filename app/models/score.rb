# frozen_string_literal: true

class Score < ApplicationRecord
  include AccountScoped

  before_validation :set_score

  belongs_to :scorable, polymorphic: true, optional: false, touch: true
  belongs_to :criterium, dependent: :destroy, optional: false

  private

  def set_score
    self.score = criterium.score
  end
end
