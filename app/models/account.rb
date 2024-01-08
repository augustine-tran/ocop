# frozen_string_literal: true

class Account < ApplicationRecord
  has_many :people, dependent: :destroy
  has_many :submissions, dependent: :destroy
  has_many :companies, dependent: :destroy
  has_one :primary_company, -> { where(is_primary: true) }, class_name: 'Company', dependent: :destroy

  after_create :create_primary_company

  def primary_company=(company)
    ActiveRecord::Base.transaction do
      companies.update_all(is_primary: false) # Reset the primary status of all companies # rubocop:disable Rails/SkipsModelValidations
      company.update(is_primary: true) # Set the new primary company
    end
  end

  private

  def create_primary_company
    logger.info "Creating primary company for account #{id}"
    companies.create!(is_primary: true, name:)
  end
end
