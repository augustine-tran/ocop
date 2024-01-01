# frozen_string_literal: true

class Quote < ApplicationRecord
  include AccountScoped

  validates :name, presence: true
end
