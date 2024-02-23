class CriteriaBucket < ApplicationRecord
  include AccountScoped

  has_many :criteria_groups, dependent: :destroy
  has_many :critria, through: :criteria_groups
end
