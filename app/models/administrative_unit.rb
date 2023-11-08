# frozen_string_literal: true

class AdministrativeUnit < ApplicationRecord
  enum level: {
    province: 'province',
    district: 'district',
    ward: 'ward'
  }
end
