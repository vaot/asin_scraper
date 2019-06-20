class ProductCreationService
  def initialize(asin_number)
    @asin_number = asin_number
  end

  def fetch_or_create(force: false)
    Product.where(asin: @asin_number).first_or_create.tap do |product|
      if !product.active? || force
        AsinScraperWorker.perform_async(product.asin)
      end
    end
  end
end
