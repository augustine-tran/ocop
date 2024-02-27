# frozen_string_literal: true

module SubmissionsHelper
  def companies_collection
    Current.person.companies
  end
end
