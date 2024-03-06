# frozen_string_literal: true

class Assistant < ApplicationRecord
  include Personable
  include AccountsSharingIdentity
end
