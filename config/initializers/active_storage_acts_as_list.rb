# frozen_string_literal: true

# config/initializers/active_storage_acts_as_list.rb
module ActiveStorageAttachmentList
  extend ActiveSupport::Concern

  included do
    acts_as_list scope: %i[record_id record_type name]
    default_scope { order(:position) }
  end
end

Rails.configuration.to_prepare do
  ActiveSupport.on_load(:active_storage_attachment) { include ActiveStorageAttachmentList }
end