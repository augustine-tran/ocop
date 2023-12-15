# frozen_string_literal: true

class User < ApplicationRecord
  include Personable
  include AccountsSharingIdentity

  enum role: {
    admin: 'admin',
    editor: 'editor',
    writer: 'writer'
  }
end
