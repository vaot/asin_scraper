require 'nokogiri'
require 'open-uri'

class AsinScraperService

  AMAZON_BASE_URL = "https://www.amazon.com/dp"
  UNIT_OF_DIMENSIONS = 100

  def initialize(asin_number)
    @asin_number = asin_number
  end

  def fetch
    AmazonProduct.new(html_doc).tap do |presenter|
      product.title = presenter.title
      product.category = presenter.category
      product.best_seller_rank = presenter.best_seller_rank

      product.length_in_hundreds = presenter.dimensions[:length] * UNIT_OF_DIMENSIONS
      product.width_in_hundreds = presenter.dimensions[:width] * UNIT_OF_DIMENSIONS
      product.height_in_hundreds = presenter.dimensions[:height] * UNIT_OF_DIMENSIONS
      product.status = Product::STATUSES[:active]

      product.save!
    end
  end

  private

  def product
    @product ||= Product.where(asin: @asin_number).first_or_initialize
  end

  def html_doc
    @html_doc ||= Nokogiri::HTML(open(to_url).read)
  end

  def to_url
    "#{AMAZON_BASE_URL}/#{@asin_number}"
  end
end
