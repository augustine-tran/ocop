# frozen_string_literal: true

class Tombstone < ApplicationRecord
  include Personable
  include AccountsSharingIdentity
end
