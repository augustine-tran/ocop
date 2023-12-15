# frozen_string_literal: true

class Client < ApplicationRecord
  include Personable
  include AccountsSharingIdentity

  belongs_to :company

  enum role: {
    writer: 'writer'
  }
end
