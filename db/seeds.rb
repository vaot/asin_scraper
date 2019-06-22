TITLES_EXPS = [
  "css('#productTitle').first.content.strip"
]

CATEGORY_EXPS = [
  "css('#wayfinding-breadcrumbs_container').first.content.gsub('\n', '').split.join(' ')"
]

IMAGE_EXPS = [
  "css('#landingImage').first.attributes['data-old-hires'].value.presence",
  "css('#landingImage').first.attributes['src'].value.presence",
  "css('#main-image-container img').first.attributes['src'].value"

]

RANK_EXPS = [
  "css('#SalesRank').first.content.gsub('\n', '').match(/#[0-9]+/)[0].strip.gsub('#', '').to_i",
  "at('th:contains(\"Best Sellers Rank\")').parent.content.gsub('\n', '').match(/#[0-9]+/)[0].strip.gsub('#', '').to_i"
]

DIMENSIONS_EXPS = [
  "at('li:contains(\"Product Dimensions\")').content.strip.gsub('\n', '').split.select { |s| s.match(/[0-9]+/) }.map(&:to_f)",
  "at('tr:contains(\"Product Dimensions\")').content.strip.gsub('\n', '').split.select { |s| s.match(/[0-9]+/) }.map(&:to_f)",
  "at('li:contains(\"Package Dimensions\")').content.strip.gsub('\n', '').split.select { |s| s.match(/[0-9]+/) }.map(&:to_f)",
  "at('tr:contains(\"Package Dimensions\")').content.strip.gsub('\n', '').split.select { |s| s.match(/[0-9]+/) }.map(&:to_f)",
  "at('li:contains(\"Item Dimensions\")').content.strip.gsub('\n', '').split.select { |s| s.match(/[0-9]+/) }.map(&:to_f)",
  "at('tr:contains(\"Item Dimensions\")').content.strip.gsub('\n', '').split.select { |s| s.match(/[0-9]+/) }.map(&:to_f)",
  "at('li:contains(\"Parcel Dimensions\")').content.strip.gsub('\n', '').split.select { |s| s.match(/[0-9]+/) }.map(&:to_f)",
  "at('tr:contains(\"Parcel Dimensions\")').content.strip.gsub('\n', '').split.select { |s| s.match(/[0-9]+/) }.map(&:to_f)"
]

TITLES_EXPS.each do |ex|
  ScraperExpression.create(key: "title", expression: ex)
end

CATEGORY_EXPS.each do |ex|
  ScraperExpression.create(key: "category", expression: ex)
end

IMAGE_EXPS.each do |ex|
  ScraperExpression.create(key: "image_url", expression: ex)
end

RANK_EXPS.each do |ex|
  ScraperExpression.create(key: "best_seller_rank", expression: ex)
end

DIMENSIONS_EXPS.each do |ex|
  ScraperExpression.create(key: "dimensions", expression: ex)
end
