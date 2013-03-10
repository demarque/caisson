#*************************************************************************************
# TOCOMMENT
#*************************************************************************************
module Caisson::Helpers::Form::Field
  class Base
    #*************************************************************************************
    # CONSTRUCTOR
    #*************************************************************************************
    def initialize(core)
      @core = core
    end

    private

    #*************************************************************************************
    # PRIVATE INSTANCE METHODS
    #*************************************************************************************
    def parse_text_options(options)
      options[:class] = ['text-field', options.delete(:class), options.delete(:field_size)].compact.join(' ')

      if options[:validates]
        options["data-validations"] = options.delete(:validates)

        case
          when options["data-validations"].include?('max-') then options[:maxlength] = options["data-validations"].match(/max-[0-9]+/).to_s.split('-').last.to_i
          when options["data-validations"].include?('within-') then options[:maxlength] = options["data-validations"].match(/within-([0-9]+)-([0-9]+)/).to_s.split('-').last.to_i
          when options["data-validations"].include?('creditcard-') then options[:maxlength] = 19
        end
      end

      return options
    end


    def method_missing(*args, &block)
      if [:check_box_tag, :content_tag, :hidden_field_tag, :options_for_select, :password_field_tag, :select_tag, :text_area_tag, :text_field_tag].include?(args.first)
        return @core.send(*args, &block)
      else
        raise NoMethodError.new("undefined local variable or method '#{args.first}' for #{self.class}")
      end
    end
  end
end
