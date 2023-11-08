# frozen_string_literal: true

module Recording::Eventable
  extend ActiveSupport::Concern

  included do
    has_many :events, dependent: :destroy

    after_create :track_created
    after_update :track_updated
  end

  def track_event(action, recordable_previous_type: nil, recordable_previous_id: nil, **particulars)
    Event.create! \
      recording: self, recordable:, recordable_previous_type:, recordable_previous_id:, \
      creator: Current.person, action:,
      detail: Event::Detail.new(particulars)
  end

  private

  def track_created
    track_event :created
  end


  def updated_to_active_action
    return unless active?

    if drafted_before_last_save?
      :active
    elsif archived_before_last_save?
      :unarchived
    elsif trashed_before_last_save?
      :untrashed
    end
  end

  def status_updated_action
    return nil unless saved_change_to_status?

    if active?
      updated_to_active_action
    elsif archived?
      :archived
    elsif trashed?
      :trashed
    end
  end

  def updated_action
    status_updated_action || :updated
  end

  def track_updated
    track_event updated_action,
                recordable_previous_type: recordable_type_before_last_save,
                recordable_previous_id: recordable_id_before_last_save,
                title_changed: recordable_before_last_save.title != recordable.title,
                description_changed: recordable_before_last_save.description != recordable.description
  end
end
