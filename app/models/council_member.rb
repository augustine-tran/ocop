# frozen_string_literal: true

class CouncilMember < ApplicationRecord
  belongs_to :council
  belongs_to :person

  delegate :name, :department, to: :person

  enum role: {
    president: 'president',
    judge: 'judge'
  }
end
