# frozen_string_literal: true

class Companies::ProductsController < ApplicationController
  before_action :set_company
  before_action :set_product, only: %i[show edit update destroy]

  def index
    @products = @company.products
  end

  def show; end

  def new
    @product = @company.products.build
  end

  def edit; end

  def create
    @product = @company.products.build(product_params)

    if @product.save
      redirect_to company_product_path(@company, @product), notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def update
    if @product.update(product_params)
      redirect_to company_product_path(@company, @product), notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to company_products_path(@company), notice: 'Product was successfully destroyed.'
  end

  private

  def set_company
    @company = Company.find(params[:company_id])
  end

  def set_product
    @product = @company.products.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :status, :description, photos: [])
  end
end
