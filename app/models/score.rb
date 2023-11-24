# frozen_string_literal: true

class Score < ApplicationRecord
  belongs_to :scorable, polymorphic: true, touch: true, optional: false
  belongs_to :criterium, touch: true, dependent: :destroy, optional: false
end
