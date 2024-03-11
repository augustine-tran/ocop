# frozen_string_literal: true

class Assessment < ApplicationRecord
  include Scorable, Status
  include Rankable

  belongs_to :submission
  delegated_type :assessable, types: Assessable::TYPES
  belongs_to :judge, class_name: 'Person', optional: true

  delegate :company, :year, :product_group, :name, :account, :files, :description, to: :submission
  delegate :can_submit?, to: :assessable

  after_save :notify_submission, if: :status_previously_changed_to_active?

  delegate :submit, :notify_submission, to: :assessable

  def can_approve?
    assessable.is_a?(SelfAssessment) && approval?
  end

  def approve
    return unless can_approve?

    transaction do
      update(status: :active)
      submission.update(status: :active)
    end
  end

  private

  def status_previously_changed_to_active?
    status_previously_changed? && active?
  end
end
