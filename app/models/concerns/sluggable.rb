# frozen_string_literal: true

module Sluggable
  extend ActiveSupport::Concern

  included do
    before_validation :generate_slug, if: -> { title.present? && (new_record? || title_changed?) }
    validates :slug, presence: true, uniqueness: true
  end

  private

  def generate_slug
    normalized_title = normalize_text title
    base_slug = normalized_title.parameterize
    self.slug = generate_unique_slug(base_slug)
  end

  def generate_unique_slug(base_slug)
    slug = base_slug
    counter = 1

    while self.class.exists?(slug:)
      slug = "#{base_slug}-#{counter}"
      counter += 1
    end

    slug
  end

  def normalize_text(text)
    parameterize_vietnamese(text)
  end

  def parameterize_vietnamese(string)
    # Convert Vietnamese characters to their ASCII equivalents
    vietnamese_to_ascii = {
      'á' => 'a', 'à' => 'a', 'ả' => 'a', 'ã' => 'a', 'ạ' => 'a',
      'ă' => 'a', 'ắ' => 'a', 'ằ' => 'a', 'ẳ' => 'a', 'ẵ' => 'a', 'ặ' => 'a',
      'â' => 'a', 'ấ' => 'a', 'ầ' => 'a', 'ẩ' => 'a', 'ẫ' => 'a', 'ậ' => 'a',
      'đ' => 'd',
      'é' => 'e', 'è' => 'e', 'ẻ' => 'e', 'ẽ' => 'e', 'ẹ' => 'e',
      'ê' => 'e', 'ế' => 'e', 'ề' => 'e', 'ể' => 'e', 'ễ' => 'e', 'ệ' => 'e',
      'í' => 'i', 'ì' => 'i', 'ỉ' => 'i', 'ĩ' => 'i', 'ị' => 'i',
      'ó' => 'o', 'ò' => 'o', 'ỏ' => 'o', 'õ' => 'o', 'ọ' => 'o',
      'ô' => 'o', 'ố' => 'o', 'ồ' => 'o', 'ổ' => 'o', 'ỗ' => 'o', 'ộ' => 'o',
      'ơ' => 'o', 'ớ' => 'o', 'ờ' => 'o', 'ở' => 'o', 'ỡ' => 'o', 'ợ' => 'o',
      'ú' => 'u', 'ù' => 'u', 'ủ' => 'u', 'ũ' => 'u', 'ụ' => 'u',
      'ư' => 'u', 'ứ' => 'u', 'ừ' => 'u', 'ử' => 'u', 'ữ' => 'u', 'ự' => 'u',
      'ý' => 'y', 'ỳ' => 'y', 'ỷ' => 'y', 'ỹ' => 'y', 'ỵ' => 'y'
    }
    # Replace Vietnamese characters with their ASCII equivalents
    parameterized_string = string.dup

    vietnamese_to_ascii.each do |vietnamese, ascii|
      parameterized_string.gsub!(vietnamese, ascii)
    end

    parameterized_string.parameterize
  end
end
