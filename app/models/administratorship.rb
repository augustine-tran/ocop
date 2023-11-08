# frozen_string_literal: true

class Administratorship < ApplicationRecord
  belongs_to :account
  belongs_to :person
end
