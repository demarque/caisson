#*************************************************************************************
# TOCOMMENT
#*************************************************************************************
module Caisson::Helpers::Form::Builder::Field
  class Password < Caisson::Helpers::Form::Builder::Field::Base
    #*************************************************************************************
    # PUBLIC INSTANCE METHODS
    #*************************************************************************************
    def build
      Caisson::Helpers::Form::Field::Password.new(@core).build(field_name, value, @options)
    end
  end
end
