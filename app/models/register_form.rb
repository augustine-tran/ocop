# frozen_string_literal: true

class RegisterForm
  extend ActiveModel::Translation
  include ActiveModel::Model

  attr_accessor :owner_name, :owner_email, :owner_address, :owner_phone, :owner_job_title, :company_name,
                :product_name, :sample_quantities

  def initialize(submission, params = nil)
    @submission = submission
    @company = submission.company
    @owner = @company.owners.first_or_initialize

    load_data_from(params) || load_default_data
  end

  def load_data_from(params)
    return if params.nil?

    self.owner_name = params[:owner_name]
    self.owner_email = params[:owner_email]
    self.owner_address = params[:owner_address]
    self.owner_phone = params[:owner_phone]
    self.owner_job_title = params[:owner_job_title]
    self.company_name = params[:company_name]
    self.product_name = params[:product_name]
    self.sample_quantities = params[:sample_quantities]

    true
  end

  def load_default_data
    self.owner_name = @owner.name
    self.owner_email = @owner.email
    self.owner_address = @owner.address
    self.owner_phone = @owner.phone
    self.owner_job_title = @owner.job_title
    self.company_name = @company.name
    self.product_name = @submission.name
  end

  def criteria_group_name
    @submission.criteria_group.name
  end

  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      @owner.update!(name: owner_name, email: owner_email, address: owner_address, phone: owner_phone,
                     job_title: owner_job_title)
      @company.update!(name: company_name)
    end

    true
  rescue ActiveRecord::RecordInvalid
    false
  end

  def generate_pdf
    Submission::RegisterPdf.new(self)
  end
end
