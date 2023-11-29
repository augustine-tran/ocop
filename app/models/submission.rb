# frozen_string_literal: true

class Submission < ApplicationRecord
  include Scorable, Status, AccountScoped

  enum product_group: {
    group1: 'group1',
    group2: 'group2'
  }

  belongs_to :product, optional: false, touch: true
end
