Rails.application.config.middleware.insert_before 0, Rack::Cors do
  if Rails.env.development?
    allow do
      origins '*'
      resource '*',
        headers: :any,
        methods: %i(get post put patch delete options head)
    end
  end

  if Rails.env.production?
    raise "CORS_ORIGINS env is required" unless ENV['CORS_ORIGINS'].present?

    allow do
      origins *ENV['CORS_ORIGINS'].split(',').map { |origin| origin.strip }
      resource '*',
        headers: :any,
        methods: %i(get post put patch delete options head)
    end
  end
end
