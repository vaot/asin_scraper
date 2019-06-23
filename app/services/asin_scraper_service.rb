require 'nokogiri'

class AsinScraperService

  REQUIRED_ATTRS = %i(title amazon_image_url category best_seller_rank)
  AMAZON_BASE_URL = "https://www.amazon.com/dp"
  UNIT_OF_DIMENSIONS = 100

  def self.valid?(product)
    REQUIRED_ATTRS.map { |prop| product.send(prop).present? }.any?
  end

  def initialize(asin_number)
    @asin_number = asin_number
  end

  def fetch
    AmazonProduct.new(html_doc).tap do |presenter|
      product.title = presenter.title
      product.category = presenter.category
      product.best_seller_rank = presenter.best_seller_rank
      product.amazon_image_url = presenter.image_url

      product.length_in_hundreds = presenter.dimensions[:length] * UNIT_OF_DIMENSIONS
      product.width_in_hundreds = presenter.dimensions[:width] * UNIT_OF_DIMENSIONS
      product.height_in_hundreds = presenter.dimensions[:height] * UNIT_OF_DIMENSIONS

      if self.class.valid?(product)
        product.status = Product::STATUSES[:active]
      end

      product.save!
    end

    product
  end

  private

  def product
    @product ||= Product.where(asin: @asin_number).first_or_initialize
  end

  def html_doc
    @html_doc ||= Nokogiri::HTML(get_html)
  end

  def get_html
    script = Rails.root.join("lib", "phantomjs_page_download.js")

    %x(phantomjs #{script} #{to_url} > "/tmp/page_test_#{@asin_number}.html")
    cmd_status = $?

    if cmd_status.exitstatus != 0
      ""
    else
      File.read("/tmp/page_test_#{@asin_number}.html")
    end
  end

  def to_url
    "#{AMAZON_BASE_URL}/#{@asin_number}"
  end
end
