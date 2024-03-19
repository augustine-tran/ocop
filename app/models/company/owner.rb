# frozen_string_literal: true

class Company::Owner < ApplicationRecord
  include LetterAvatar::HasAvatar

  belongs_to :company
end
