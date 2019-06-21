Sidekiq.configure_server do |config|
  if Rails.env.production?
    config.redis = { url: 'redis://redis:6379/0' }
  end
end
