class AmazonProduct

  AVAILABLE_ATTRS = %i(title image_url category best_seller_rank dimensions)

  def initialize(html_doc)
    @html_doc = html_doc
  end

  def method_missing(m, *args, &block)
    if AVAILABLE_ATTRS.include?(m)
      args = args.push(m.to_s)
      send(:perform, *args, &block)
    else
      super(m, *args, &block)
    end
  end

  def perform(attribute)
    ScraperExpression.where(key: attribute).find_each do |record|
      base = safe_call do
        @html_doc.instance_eval(record.expression)
      end

      return base if base.present?
    end

    nil
  end

  def dimensions
    base = nil

    ScraperExpression.where(key: "dimensions").find_each do |record|
      base = safe_call do
        @html_doc.instance_eval(record.expression)
      end

      break if base.present?
    end

    unless base.present?
      return Hash.new(0)
    end

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
end
