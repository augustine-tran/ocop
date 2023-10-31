# frozen_string_literal: true

module AccountsSharingIdentity
  extend ActiveSupport::Concern

  included do
    belongs_to :identity

    delegate :name, :email, to: :identity
  end
end
