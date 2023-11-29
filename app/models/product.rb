# frozen_string_literal: true

class Product < ApplicationRecord
  include AccountScoped, Status

  belongs_to :company, touch: true, dependent: :destroy
  has_many :submissions, dependent: :destroy
end
