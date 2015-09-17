$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
ENV['RACK_ENV'] = 'test'

require 'http_remocon'
require 'rack/test'
require 'sucker_punch/testing/inline'
require 'pry'

RSpec.configure do |config|
  config.include Rack::Test::Methods

  config.define_derived_metadata do |meta|
    meta[:aggregate_failures] = true unless meta.key?(:aggregate_failures)
  end
end
