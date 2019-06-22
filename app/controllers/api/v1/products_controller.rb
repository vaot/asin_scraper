class Api::V1::ProductsController < ApplicationController
  before_action :validate_asin, only: [:fetch]
  before_action :require_resource, only: [:destroy, :show]

  def index
    render json: Product.active.order("created_at desc")
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

  def require_resource
    unless product.present?
      render json: {}, status: :not_found
      return
    end
  end

  def validate_asin
    unless params[:id].match(/[0-9a-zA-Z]{10}/)
      render json: { error: "Invalid ASIN number" }, status: :bad_request
      return
    end
  end
end
