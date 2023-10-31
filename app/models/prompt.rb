# frozen_string_literal: true

class Prompt < ApplicationRecord
  include AccountScoped

  belongs_to :account
  has_rich_text :description

  has_one_attached :prompt_image do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end

  validates :title, :prompt_image, presence: true
end
