# Cache pages so that we don't have to scrap Amazon every time.
# Improvement: Consider caching these pages on Amazon S3, since our redis
# instance may get extremely large over time.
class PageCacheService

  TTL = 1.hour

  def initialize(asin)
    @asin = asin
  end

  def fetch(&block)
    if page = redis.get(cache_key)
      page
    else
      block.call.tap do |result|
        redis.setex(cache_key, TTL, result)
      end
    end
  end

  def cached?
    redis.exists(cache_key)
  end

  private

  def cache_key
    "asin_scraper_page_cache:#{@asin}"
  end

  def redis
    @redis ||= AsinScraper.redis
  end
end
