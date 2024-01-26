# frozen_string_literal: true

class PanelAssessment < ApplicationRecord
  include Assessable

  belongs_to :judge, class_name: 'Person'
end
