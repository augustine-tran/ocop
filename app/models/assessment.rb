# frozen_string_literal: true

class Assessment < ApplicationRecord
  include Scorable, Status

  belongs_to :submission
  delegated_type :assessable, types: Assessable::TYPES
  belongs_to :judge, class_name: 'Person', optional: true

  delegate :year, :product_group, :name, :account, :photos, :files, :description, to: :submission
  delegate :can_submit?, to: :assessable

  after_save :notify_submission, if: :status_previously_changed_to_active?

  def submit
    update(status: Assessment.statuses[:active]) if can_submit?
  end

  private

  def status_previously_changed_to_active?
    status_previously_changed? && active?
  end

  def notify_submission
    assessable.notify_submission
  end
end
