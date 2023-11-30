# frozen_string_literal: true

class Product < ApplicationRecord
  include AccountScoped, Status

  has_many_attached :photos do |attachable|
    attachable.variant :thumb, resize_to_limit: [150, nil]
  end

  has_rich_text :description
  belongs_to :company, touch: true, dependent: :destroy
  has_many :submissions, dependent: :destroy
end
