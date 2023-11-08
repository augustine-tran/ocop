# frozen_string_literal: true

module Account::Recordings
  extend ActiveSupport::Concern

  included do
    has_many :recordings, dependent: :destroy
  end

  def record(recordable, children: nil, parent: nil, creator: Current.person, **options)
    transaction do
      recordable.save!
      options.merge!(recordable:, parent:, creator:)

      recordings.create!(options).tap do |recording|
        Array(children).each do |child|
          record child, parent: recording, creator:
        end
      end
    end
  end
end
