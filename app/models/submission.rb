# frozen_string_literal: true

class Submission < ApplicationRecord
  include Scorable, Status

  belongs_to :product, touch: true, optional: false
end
