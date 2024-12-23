# frozen_string_literal: true

class Council < ApplicationRecord
  include AccountScoped

  belongs_to :criteria_bucket, optional: true

  has_many :members, dependent: :destroy, class_name: 'CouncilMember'
  has_many :people, through: :members, source: :person
  has_one :council_president, lambda {
                                where council_members: { role: :president }
                              },
          class_name: 'CouncilMember', dependent: :nullify
  has_one :president, through: :council_president, source: :person
  has_many :submissions, dependent: :destroy
end
