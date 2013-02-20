module Caisson
  module Implants
  end
end

if defined? Rails::Railtie
  require 'caisson/implants/railtie'
elsif defined? Rails::Initializer
  raise "caisson is not compatible with Rails 2.3 or older"
end
