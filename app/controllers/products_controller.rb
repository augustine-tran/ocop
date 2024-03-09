# frozen_string_literal: true

class ProductsController < ApplicationController
  allow_unauthenticated_access only: %i[index show]
  before_action :set_product, only: %i[show]

  layout 'posts'

  def index
    @products = Current.account.products.ordered_active.limit 10
  end

  def show; end

  private

  def set_product
    @product = Current.account.products.find_by(slug: params[:id])
  end
end
