# frozen_string_literal: true

class Client < ApplicationRecord
  include Personable
  include AccountsSharingIdentity

  enum role: {
    writer: 'writer'
  }

  belongs_to :company

  accepts_nested_attributes_for :company

  after_initialize :set_default_role, if: :new_record?

  validates :company, presence: true

  private

  def set_default_role
    self.role ||= :writer
  end
end
