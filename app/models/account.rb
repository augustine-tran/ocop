# frozen_string_literal: true

class Account < ApplicationRecord
  has_many :people, dependent: :destroy
end
