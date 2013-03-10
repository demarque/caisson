#*************************************************************************************
# TOCOMMENT
#*************************************************************************************
module Caisson::Helpers::Form::Builder::Field
  class Select < Caisson::Helpers::Form::Builder::Field::Base
    #*************************************************************************************
    # PUBLIC INSTANCE METHODS
    #*************************************************************************************
    def build
      @options.reverse_merge!(choices: nil, include_blank: false)

      choices = parse_choices @options[:choices]

      @options.delete(:choices)
      @options.delete(:include_blank)
      @options[:translate] = false

      Caisson::Helpers::Form::Field::Select.new(@core).build(field_name, choices, value, @options)
    end

    private

    #*************************************************************************************
    # PRIVATE INSTANCE METHODS
    #*************************************************************************************
    def parse_choices(choices)
      if choices
        if not choices.is_a? Array or not choices.first.is_a? Array
          # choices are a list of records
          choices = choices.choices_for_select
          choices.insert(0, interpreti.blank_choice(name)) if @options[:include_blank]
        end
      else
        choices = interpreti.field_choices(name, include_blank: @options[:include_blank])
      end

      return choices
    end

  end
end
