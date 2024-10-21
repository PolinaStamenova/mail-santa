require 'vcr'
require 'webmock/rspec'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes' # Where to save the cassettes
  config.hook_into :webmock # Hook into webmock to intercept HTTP requests
  config.configure_rspec_metadata! # Automatically tag RSpec tests with :vcr

  # Allow HTTP connections when no cassette is available (optional)
  config.allow_http_connections_when_no_cassette = true

  # Optionally filter sensitive data, such as API keys
  config.filter_sensitive_data('<OPENAI_API_KEY>') { Rails.application.credentials.dig(:openai, :api_key) }
end
