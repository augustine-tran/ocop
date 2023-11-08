# frozen_string_literal: true

class Address < ApplicationRecord
  include Recordable

  belongs_to :ward, class_name: 'AdministrativeUnit'
  belongs_to :district, class_name: 'AdministrativeUnit'
  belongs_to :province, class_name: 'AdministrativeUnit'
end
