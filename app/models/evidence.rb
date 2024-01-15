# frozen_string_literal: true

class Evidence < ApplicationRecord
  belongs_to :score

  has_many_attached :photos do |attachable|
    attachable.variant :thumb, resize_to_limit: [150, nil]
    attachable.variant :thumb_fixed_height, resize_to_limit: [nil, 210]
  end

  has_many_attached :files
  has_rich_text :story
end
