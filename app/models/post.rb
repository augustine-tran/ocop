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

  def self.ransackable_attributes(_auth_object = nil)
    %w[title body category_id status]
  end

  def cleaned_content
    body.to_plain_text
  end

  def excerpt(length = 100, more_text = '...')
    cleaned_content.split.first(length).join(' ') + more_text
  end
end
