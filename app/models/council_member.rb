# frozen_string_literal: true

class CouncilMember < ApplicationRecord
  belongs_to :council
  belongs_to :person

  enum role: {
    president: 'president',
    member: 'member'
  }
end
