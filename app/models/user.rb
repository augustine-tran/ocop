# frozen_string_literal: true

class User < ApplicationRecord
  include Personable
  include AccountsSharingIdentity

  belongs_to :company, optional: true
end
