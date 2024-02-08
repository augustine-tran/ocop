# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    redirect_to admin_home_url if Current.account.accountable.is_a?(DistrictDepartment)
  end
end
