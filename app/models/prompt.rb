# frozen_string_literal: true

class Prompt < ApplicationRecord
  include AccountScoped

  belongs_to :account
  has_rich_text :description

  validates :title, :prompt_image, presence: true
end
