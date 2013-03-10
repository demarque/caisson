module Caisson::Implants
  class Railtie < Rails::Railtie
    initializer "caisson" do |app|
      ActiveSupport.on_load :action_view do
        require 'caisson/helpers'
      end

      if defined? Mongoid
        require 'caisson/implants/mongoid'
      end
    end
  end
end
