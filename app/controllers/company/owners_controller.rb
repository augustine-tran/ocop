# frozen_string_literal: true

class Company::OwnersController < ApplicationController
  before_action :set_company
  before_action :set_company_owner, only: %i[show edit update destroy]

  # GET /company/owners or /company/owners.json
  def index
    @company_owners = Company::Owner.all
  end

  # GET /company/owners/1 or /company/owners/1.json
  def show; end

  # GET /company/owners/new
  def new
    @company_owner = @company.owners.new
  end

  # GET /company/owners/1/edit
  def edit; end

  # POST /company/owners or /company/owners.json
  def create
    @company_owner = @company.owners.new(company_owner_params)

    respond_to do |format|
      if @company_owner.save
        format.html do
          redirect_to company_owners_url(@company),
                      notice: t(:create_success, name: Company::Owner.model_name.human)
        end
        format.json { render :show, status: :created, location: @company_owner }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @company_owner.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @company_owner.update(company_owner_params)
        format.html do
          redirect_to company_owners_url(@company),
                      notice: t(:update_success, name: Company::Owner.model_name.human)
        end
        format.json { render :show, status: :ok, location: @company_owner }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @company_owner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /company/owners/1 or /company/owners/1.json
  def destroy
    @company_owner.destroy!

    respond_to do |format|
      format.html do
        redirect_to company_owners_url(@company), notice: t(:destroy_success, name: Company::Owner.model_name.human)
      end
      format.json { head :no_content }
    end
  end

  private

  def set_company
    @company = Company.find(params[:company_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_company_owner
    @company_owner = @company.owners.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def company_owner_params
    params.require(:company_owner).permit(:name, :email, :phone, :address, :job_title)
  end
end
