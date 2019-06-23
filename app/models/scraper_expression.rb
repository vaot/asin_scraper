class ScraperExpression < ActiveRecord::Base
  # Important that we dont allow breaking of clauses. That is:
  # "input".gsub('u', '');AnotherClause
  # the above is not allowed
  validates :expression, format: { without: /(\);|[a-zA-Z0-9];)/ }
end
