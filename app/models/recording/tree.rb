# frozen_string_literal: true

module Recording::Tree
  extend ActiveSupport::Concern

  included do
    belongs_to :parent, class_name: 'Recording', touch: true, optional: true, inverse_of: :children
    has_many :children, class_name: 'Recording', foreign_key: :parent_id, dependent: :destroy, inverse_of: :parent
  end
end
