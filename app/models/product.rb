# frozen_string_literal: true

class Product < ApplicationRecord
  include AccountScoped, Status
  include Sluggable

  validates :title, presence: true

  has_many_attached :files do |attachable|
    attachable.variant :thumb, resize_to_limit: [150, nil]
    attachable.variant :large, resize_to_limit: [720, nil]
  end

  has_rich_text :body
  belongs_to :company, touch: true, dependent: :destroy
  belongs_to :category, touch: true, dependent: :destroy

  scope :ordered_active, -> { where(status: :active).order(updated_at: :desc) }
end
