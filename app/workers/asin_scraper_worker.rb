class AsinScraperWorker
  include Sidekiq::Worker

  def perform(asin_number)
    AsinScraperService.new(asin_number).fetch
  end
end
