# frozen_string_literal: true

class Company < ApplicationRecord
  include Recordable

  enum legal_type: {
    pc: 'pc',
    llc: 'llc',
    js: 'joined-stock',
    htx: 'htx'
  }
end
