$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
ENV['RACK_ENV'] = 'test'

require 'http_remocon'
require 'rack/test'

RSpec.configure do |config|
  config.include Rack::Test::Methods
end
