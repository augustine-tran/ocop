# frozen_string_literal: true

class User < ApplicationRecord
  include Personable
  include AccountsSharingIdentity
end
