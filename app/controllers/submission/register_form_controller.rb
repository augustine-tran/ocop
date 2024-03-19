# frozen_string_literal: true

class Submission::RegisterFormController < ApplicationController
  before_action :set_submission

  def new
    @register_form = RegisterForm.new @submission
  end

  def create
    @register_form = RegisterForm.new @submission, register_form_params

    if @register_form.save
      disposition = params[:disposition] || 'inline'
      send_data @register_form.generate_pdf.render, filename: "#{@register_form.product_name}.pdf",
                                                    type: 'application/pdf', disposition:
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def register_form_params
    params.require(:register_form).permit(:owner_name, :owner_email, :owner_address, :owner_phone, :owner_job_title,
                                          :company_name, :product_name, :sample_quantities)
  end

  def set_submission
    @submission = Submission.find(params[:id])
  end
end
