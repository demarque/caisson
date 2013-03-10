#*************************************************************************************
# TOCOMMENT
#*************************************************************************************
module Caisson::Helpers::Form::Builder::Field
  class Checkbox < Caisson::Helpers::Form::Builder::Field::Base
    #*************************************************************************************
    # PUBLIC INSTANCE METHODS
    #*************************************************************************************
    def build
      @options[:label] = label

      Caisson::Helpers::Form::Field::Checkbox.new(@core).build(field_name, value, @options)
    end
  end
end
