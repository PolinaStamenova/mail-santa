Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://mailsanta-2a6e63705071.herokuapp.com', 'https://myapp.com'

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options]
  end
end