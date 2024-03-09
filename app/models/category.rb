# frozen_string_literal: true

class Category < ApplicationRecord
  include Sluggable

  normalizes :title, with: -> { _1.strip }

  validates :title, presence: true

  belongs_to :parent, optional: true, class_name: 'Category'
  has_many :children, class_name: 'Category', foreign_key: :parent_id, dependent: :destroy

  has_many :posts, dependent: :destroy
end
