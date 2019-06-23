#
# Prensenter class that takes an Nokokiri document of the amazon page
# and extracts given properties defined at AVAILABLE_ATTRS.
# The expressions used to extract these properties should be defined as ScraperExpression
# with its key having the same name of the property being extracted.
#
class AmazonProduct

  AVAILABLE_ATTRS = %i(title image_url category best_seller_rank dimensions)

  def initialize(html_doc)
    @html_doc = html_doc
  end

  # Method missing will fallback to this perform with the attribute name.
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

  # We need to be cautious with swallowing exceptions like this,
  # but since these expressions are added via admin, we dont
  # want to take the app down for these.
  def safe_call(&block)
    begin
      block.call
    rescue NoMethodError => e
      nil
    end
  end

  def method_missing(property_name, *args, &block)
    if AVAILABLE_ATTRS.include?(property_name)
      args = args.push(property_name.to_s)
      send(:perform, *args, &block)
    else
      super(property_name, *args, &block)
    end
  end
end
