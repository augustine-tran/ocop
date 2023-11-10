# frozen_string_literal: true

module Recording::Employment
  extend ActiveSupport::Concern

  delegate :employees, to: :children

  included do
    scope :of_company, ->(parent_id) { where(parent_id:) }

    def director
      Current.account.recordings.employees.of_company(id).detect { |r| r.recordable.no_manager? }
    end
  end
end
