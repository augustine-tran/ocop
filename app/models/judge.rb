# frozen_string_literal: true

class Judge < ApplicationRecord
  include Personable
  include AccountsSharingIdentity
end
