# frozen_string_literal: true

module Recording::Commentable
  extend ActiveSupport::Concern

  delegate :comments, to: :children
end
