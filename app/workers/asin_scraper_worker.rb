class AsinScraperWorker
  include Sidekiq::Worker

  def perform(asin_number)
    product = AsinScraperService.new(asin_number).fetch

    if product.persisted?
      ActionCable.server.broadcast('products', { product: product })
    end
  end
end
