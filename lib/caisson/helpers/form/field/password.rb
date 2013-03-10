#*************************************************************************************
# Build complex graphical password field.
#*************************************************************************************
module Caisson::Helpers::Form::Field
  class Password < Caisson::Helpers::Form::Field::Base
    #*************************************************************************************
    # PUBLIC INSTANCE METHODS
    #*************************************************************************************
    def build(name, value, options={})
      password_field_tag name, value, parse_text_options(options)
    end

  end
end
