class AmazonProduct
  def initialize(product_page_doc)
    @product_page_doc = product_page_doc
  end

  def image_url
    base = safe_call do
      @product_page_doc.css('#landingImage')
        .first
        .attributes['src']
        .value
    end

    base ||= safe_call do
      @product_page_doc.css('#main-image-container img')
        .first
        .attributes['src']
        .value
    end

    base
  end

  def title
    safe_call do
      @product_page_doc.css("#productTitle")
        .first
        .content
        .strip
    end
  end

  def category
    safe_call do
      @product_page_doc.css('#wayfinding-breadcrumbs_container')
        .first
        .content
        .gsub("\n", "")
        .split
        .join(" ")
    end
  end

  def best_seller_rank
    base = nil

    base = safe_call do
      @product_page_doc.css("#SalesRank")
        .first
        .content
        .gsub("\n", "")
        .match(/#[0-9]+/)[0]
        .strip
        .gsub("#", "")
        .to_i
    end

    base ||= safe_call do
      @product_page_doc.at("th:contains('Best Sellers Rank')")
        .parent
        .content
        .gsub("\n", "")
        .match(/#[0-9]+/)[0]
        .strip
        .gsub("#", "")
        .to_i
    end

    base
  end

  def dimensions
    base = get_dimension_elements

    unless base.present?
      return Hash.new(0)
    end

    base = base.content
      .strip
      .gsub("\n", "")
      .split
      .select { |s| s.match(/[0-9]+/) }
      .map(&:to_f)

    {
      length: base[0],
      width: base[1],
      height: base[2]
    }
  end


  private

  def safe_call(&block)
    begin
      block.call
    rescue => e
      puts e
      nil
    end
  end

  def get_dimension_elements
    possible_texts = ['Product Dimensions', 'Package Dimensions', 'Item Dimensions', 'Parcel Dimensions']
    possible_elements = ['li', 'tr']

    possible_texts.each do |text|
      possible_elements.each do |element|
        if dimension = @product_page_doc.at("#{element}:contains('#{text}')")
          return dimension
        end
      end
    end

    ""
  end
end
