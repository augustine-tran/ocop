# frozen_string_literal: true

module Status
  extend ActiveSupport::Concern

  included do
    enum status: {
      drafted: 'drafted',
      approval: 'approval',
      active: 'active',
      archived: 'archived',
      trashed: 'trashed'
    }
  end

  private

  def drafted_before_last_save?
    status_before_last_save == Recording.statuses[:drafted]
  end

  def archived_before_last_save?
    status_before_last_save == Recording.statuses[:archived]
  end

  def trashed_before_last_save?
    status_before_last_save == Recording.statuses[:trashed]
  end
end
