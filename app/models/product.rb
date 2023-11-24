# frozen_string_literal: true

class Product < ApplicationRecord
  include Status

  belongs_to :company, touch: true, optional: false
  has_many :submissions, dependent: :destroy, touch: true
end
