require "rubygems"
require "bundler/setup"

require 'rspec'

require File.expand_path('../../lib/caisson', __FILE__)

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
end
