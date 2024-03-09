# frozen_string_literal: true

class Post < ApplicationRecord
  include AccountScoped, Status
  include Sluggable

  normalizes :title, with: -> { _1.strip }

  validates :title, presence: true

  belongs_to :category, touch: true

  has_rich_text :body
  has_many_attached :files do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, nil]
    attachable.variant :large, resize_to_limit: [720, nil]
  end

  scope :ordered_active, -> { where(status: :active).order(updated_at: :desc) }
end
