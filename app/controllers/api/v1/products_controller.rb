class Api::V1::ProductsController < ApplicationController
  before_action :validate_asin, only: [:fetch]

  def index
    render json: Product.active
  end

  def show
    render json: product
  end

  def destroy
    if product.destroy
      render json: { success: true }
    end
  end

  def fetch
    render json: ProductCreationService.new(params[:id]).fetch_or_create(force: true)
  end

  private

  def product
    @product ||= Product.where(asin: params[:id]).first
  end

  def validate_asin
    unless params[:id].match(/[0-9a-zA-Z]{10}/)
      render json: { error: "Invalid ASIN number" }, status: :bad_request
      return
    end
  end
end
