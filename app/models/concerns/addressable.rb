# frozen_string_literal: true

module Addressable
  extend ActiveSupport::Concern

  included do
    has_many :addresses, as: :addressable, dependent: :destroy
  end
end
