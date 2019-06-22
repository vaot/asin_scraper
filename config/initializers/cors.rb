Rails.application.config.middleware.insert_before 0, Rack::Cors do
  if Rails.env.development?
    allow do
      origins 'localhost:4200', 'localhost:3001'
      resource '*',
        headers: :any,
        methods: %i(get post put patch delete options head)
    end
  end

  if Rails.env.production?
    allow do
      origins 'victorvaot.com', 'www.victorvaot.com', 'react.victorvaot.com'
      resource '*',
        headers: :any,
        methods: %i(get post put patch delete options head)
    end
  end
end
