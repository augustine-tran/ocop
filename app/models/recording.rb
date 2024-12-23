# frozen_string_literal: true

class Recording < ApplicationRecord
  include Tree, Status
  include Eventable

  belongs_to :account
  belongs_to :creator, class_name: 'Person', default: -> { Current.person }
end
