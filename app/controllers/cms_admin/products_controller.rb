# frozen_string_literal: true

class CmsAdmin::ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]

  # GET /cms/products or /cms/products.json
  def index
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true).order(title: :asc).page(params[:page]).per(10).includes(:company, :category)
  end

  # GET /cms/products/1 or /cms/products/1.json
  def show; end

  # GET /cms/products/new
  def new
    @product = Product.new
  end

  # GET /cms/products/1/edit
  def edit; end

  # PRODUCT /cms/products or /cms/products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to cms_admin_products_url, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cms/products/1 or /cms/products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params.except(:files_to_remove))
        remove_photos(product_params[:files_to_remove]) if product_params[:files_to_remove].present?

        format.html { redirect_to cms_admin_products_url, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cms/products/1 or /cms/products/1.json
  def destroy
    @product.destroy!

    respond_to do |format|
      format.html { redirect_to cms_products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find_by(slug: params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:title, :status, :category_id, :company_id, :body, :stars, files: [],
                                                                                               files_to_remove: [])
  end

  def remove_photos(files_to_remove)
    @product.files.where(id: files_to_remove).map(&:purge)
  end
end
