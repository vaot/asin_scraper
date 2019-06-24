module AsinScraper
  module Redis
    def redis
      @redis ||= ::Redis.new(url: to_redis_url)
    end

    def to_redis_url
      ENV.fetch("REDIS_URL") { "redis://localhost:6379/0" }
    end
  end

  extend AsinScraper::Redis
end
