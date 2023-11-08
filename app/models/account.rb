# frozen_string_literal: true

class Account < ApplicationRecord
  include Recordings

  has_many :people, dependent: :destroy
end
