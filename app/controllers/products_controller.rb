# frozen_string_literal: true

class ProductsController < ApplicationController
  allow_unauthenticated_access only: %i[index show]
  before_action :set_product, only: %i[show]

  layout 'posts'

  def index
    @products = Product.ordered_active.limit 10
  end

  def show; end

  private

  def set_product
    @product = Product.find_by(slug: params[:id])
  end
end
