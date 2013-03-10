#*************************************************************************************
# Build complex graphical input field.
#*************************************************************************************
module Caisson::Helpers::Form::Field
  class Textarea < Caisson::Helpers::Form::Field::Base
    #*************************************************************************************
    # PUBLIC INSTANCE METHODS
    #*************************************************************************************
    def build(name, value, options={})
      value = options[:value] if options[:value]
      value = value.join("\n") if value.is_a? Array

      return text_area_tag(name, value, options)
    end
  end
end
