# frozen_string_literal: true

class Ownership < ApplicationRecord
  belongs_to :account
  belongs_to :person
end
