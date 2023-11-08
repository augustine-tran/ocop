class AdministrativeUnitsController < ApplicationController
  before_action :set_administrative_unit, only: %i[ show edit update destroy ]

  # GET /administrative_units or /administrative_units.json
  def index
    @administrative_units = AdministrativeUnit.all
  end

  # GET /administrative_units/1 or /administrative_units/1.json
  def show
  end

  # GET /administrative_units/new
  def new
    @administrative_unit = AdministrativeUnit.new
  end

  # GET /administrative_units/1/edit
  def edit
  end

  # POST /administrative_units or /administrative_units.json
  def create
    @administrative_unit = AdministrativeUnit.new(administrative_unit_params)

    respond_to do |format|
      if @administrative_unit.save
        format.html { redirect_to administrative_unit_url(@administrative_unit), notice: "Administrative unit was successfully created." }
        format.json { render :show, status: :created, location: @administrative_unit }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @administrative_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /administrative_units/1 or /administrative_units/1.json
  def update
    respond_to do |format|
      if @administrative_unit.update(administrative_unit_params)
        format.html { redirect_to administrative_unit_url(@administrative_unit), notice: "Administrative unit was successfully updated." }
        format.json { render :show, status: :ok, location: @administrative_unit }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @administrative_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /administrative_units/1 or /administrative_units/1.json
  def destroy
    @administrative_unit.destroy!

    respond_to do |format|
      format.html { redirect_to administrative_units_url, notice: "Administrative unit was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_administrative_unit
      @administrative_unit = AdministrativeUnit.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def administrative_unit_params
      params.require(:administrative_unit).permit(:name, :code, :level)
    end
end
