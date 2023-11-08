# frozen_string_literal: true

module Recording::Recordables
  extend ActiveSupport::Concern

  attr_reader :recordable_before_last_save

  included do
    delegated_type :recordable, types: Recordable::TYPES, dependent: :destroy

    delegate :title, :description, to: :recordable
  end

  def recordable=(recordable)
    remember_recordable_previous
    super
  end

  def recordable_versions
    events.includes(:recordable).order(created_at: :desc)
          .map(&:recordable).uniq
  end

  private

  def remember_recordable_previous
    @recordable_before_last_save = recordable
  end
end
