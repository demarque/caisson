#*************************************************************************************
# TOCOMMENT
#*************************************************************************************
module Caisson::Helpers::Form::Builder::Field
  class Base
    attr_reader :name

    #*************************************************************************************
    # CONSTRUCTOR
    #*************************************************************************************
    def initialize(core, record, name, options={})
      @core = core
      @record = record
      @name = name

      @options = OptionParser.new(@record, @name, options).parse
    end

    #*************************************************************************************
    # PUBLIC INSTANCE METHODS
    #*************************************************************************************

    private

    #*************************************************************************************
    # PRIVATE INSTANCE METHODS
    #*************************************************************************************
    def field_id
      "#{model_name}_#{@name}"
    end

    def field_name
      "#{model_name}[#{@name}]"
    end

    def label
      interpreti.field_label(@name)
    end

    def interpreti
      @core.interpreti
    end

    def model_name
      @record.class.to_s.underscore.downcase
    end

    def value(readable=false)
      if @name.to_s.include?('[')
        parsed_name = @name.gsub(']', '[').split('[')

        return @record.read_attribute(parsed_name[0])[parsed_name[1]]
      else
        content = ''
        content = interpreti.field_option(@name) if readable

        if content.blank?
          content = @record.respond_to?(@name) ? @record.send(@name) : @record.read_attribute(@name)
        end

        return content
      end
    end

    def value_readable
      value true
    end

    def method_missing(*args, &block)
      if [:check_box, :content_tag].include?(args.first)
        return @core.send(*args, &block)
      else
        raise NoMethodError.new("undefined local variable or method '#{args.first}' for #{self.class}")
      end
    end

    class OptionParser
      def initialize(record, field_name, options)
        @field_name = field_name
        @options = options
        @record = record
      end

      def parse
        parse_id
        parse_class
        parse_placeholder
        parse_validations

        delete_junk

        return @options
      end

      private

      def delete_junk
        [:field_size, :nature].each { |n| @options.delete(n) }

        @options.delete(:label) if @options[:label] == 'undefined'
        @options.delete(:value) if @options[:value] == 'undefined'
        @options.delete(:choices) if not @options[:choices]
      end

      def parse_class
        @options[:class] = [@options[:class], @options[:field_size]].compact.join(" ") if @options[:field_size]
      end

      def parse_id
        if @options[:id] == 'undefined'
          model_name = @record.class.to_s.underscore.downcase

          @options[:id] = "#{model_name}_#{@field_name}"
        end
      end

      def parse_length_validator(opts)
        case
          when (opts[:minimum] and opts[:maximum]) then "within-#{opts[:minimum]}-#{opts[:maximum]}"
          when opts[:minimum] then "min-#{opts[:minimum]}"
          when opts[:maximum] then "max-#{opts[:maximum]}"
          when opts[:is] then "length-#{opts[:is]}"
        end
      end

      def parse_placeholder
        if @options[:placeholder] == true
          @options[:placeholder] = interpreti.field_label @field_name
        elsif not @options[:placeholder]
          @options.delete(:placeholder)
        end
      end

      def parse_validations
        validators = @record.class.validators_on(@field_name).map { |v| parse_validator v }
        validators << 'email' if @field_name.to_s.include? 'email'
        validators << set_other_validations

        data = [validators, @options.delete(:validates)].flatten.compact

        @options[:validates] = data.join(" ") if not data.empty?
      end

      def parse_validator(validator)
        return nil if validator.options[:if] and not @record.send(validator.options[:if])
        return nil if validator.options[:unless] and @record.send(validator.options[:unless])

        case validator.class.to_s
          when /ConfirmationValidator$/ then nil # TODO: Implement this feature
          when /FormatValidator$/ then nil
          when /LengthValidator$/ then parse_length_validator validator.options
          when /PresenceValidator$/ then 'blank'
          when /UniquenessValidator$/ then nil
          else nil
        end
      end

      def set_other_validations
        validators = []

        validators << 'numeric' if @record.fields[@field_name.to_s] and @record.fields[@field_name.to_s].options[:type] == Integer

        return validators
      end
    end

  end
end
