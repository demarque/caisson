#*************************************************************************************
# TOCOMMENT
#*************************************************************************************
module Caisson::Helpers::Form::Builder::FieldBuilder
  class Nature
    #*************************************************************************************
    # CONSTRUCTOR
    #*************************************************************************************
    def initialize(record, name)
      @record = record
      @name = name.to_s
    end


    #*************************************************************************************
    # PUBLIC CLASS METHODS
    #*************************************************************************************
    def self.all
      ['checkbox', 'password', 'percent', 'select', 'text', 'textarea']
      #TODO
      #'autocomplete', 'check-icon', 'country', 'file', 'money', 'static', 'switch', 'radio', 'upload', 'ticklist', 'time_field'
    end


    #*************************************************************************************
    # PUBLIC INSTANCE METHODS
    #*************************************************************************************
    def get(options={})
      options.reverse_merge!(force: nil)

      if options[:force]
        return force(options[:force])
      elsif @record.fields[@name]
        return case @record.fields[@name].options[:type].to_s.downcase
          when 'array' then 'ticklist'
          when 'boolean' then 'checkbox'
          when 'percent' then 'percent'
          when 'time' then 'time_field'
          else nature_by_name
        end
      else
        return nature_by_name
      end
    end

    private

    #*************************************************************************************
    # PRIVATE INSTANCE METHODS
    #*************************************************************************************
    def field_has_options?(field_name)
      model_obj = @record.class
      if model_obj.respond_to?(:options_for)
        return (not model_obj.options_for(field_name).empty?)
      else
        return false
      end
    end

    def field_is_one_to_many?(field_name)
      not @record.relations.select{ |k,v| v.key == field_name.to_s and v.macro == :referenced_in }.empty?
    end

    def field_is_select?(field_name)
      field_has_options?(field_name) or field_is_one_to_many?(field_name)
    end

    def force(nature)
      if Caisson::Helpers::Form::Builder::FieldBuilder::Nature.all.include?(nature)
        return nature
      else
        raise "Caisson doesn't accept the field nature '#{nature}' for the field '#{@name}'. Accepted : #{Caisson::Helpers::Form::Builder::FieldBuilder::Nature.all}"
      end
    end

    def nature_by_name
      case
        when @name.include?('country') then 'country'
        when @name.include?('password') then 'password'
        when field_is_select?(@name) then 'select'
        else 'text'
      end
    end
  end
end
