# frozen_string_literal: true

class Product < ApplicationRecord
  include AccountScoped, Status
  include Sluggable

  validates :title, presence: true

  has_many_attached :files do |attachable|
    attachable.variant :thumb, resize_and_pad: [267, 267]
    attachable.variant :large, resize_to_limit: [720, nil]
  end

  has_rich_text :body
  belongs_to :company, touch: true, dependent: :destroy
  belongs_to :category, touch: true, dependent: :destroy

  scope :ordered_active, -> { where(status: :active).order(updated_at: :desc) }

  def self.ransackable_attributes(_auth_object = nil)
    %w[slug stars status title category_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[category company]
  end

  def cleaned_content
    body.to_plain_text
  end

  def excerpt(length = 100, more_text = '...')
    cleaned_content.split.first(length).join(' ') + more_text
  end
end
