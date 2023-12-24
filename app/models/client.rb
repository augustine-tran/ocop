# frozen_string_literal: true

class Client < ApplicationRecord
  include Personable
  include AccountsSharingIdentity
end
