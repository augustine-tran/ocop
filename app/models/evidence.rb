# frozen_string_literal: true

class Evidence < ApplicationRecord
  belongs_to :score

  has_many_attached :files

  has_rich_text :story
end
