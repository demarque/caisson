#*************************************************************************************
# Build complex graphical input field.
#*************************************************************************************
module Caisson::Helpers::Form::Field
  class Text < Caisson::Helpers::Form::Field::Base
    #*************************************************************************************
    # PUBLIC INSTANCE METHODS
    #*************************************************************************************
    def build(name, value, options={})
      options = parse_text_options options

      value = value.join(';') if value.is_a? Array

      return text_field_tag name, value, options
    end
  end
end
