#*************************************************************************************
# TOCOMMENT
#*************************************************************************************
module Caisson::Helpers::Form::Builder::Field
  class Percent < Caisson::Helpers::Form::Builder::Field::Base
    #*************************************************************************************
    # PUBLIC INSTANCE METHODS
    #*************************************************************************************
    def build
      Caisson::Helpers::Form::Field::Percent.new(@core).build(field_name, value, @options)
    end
  end
end
