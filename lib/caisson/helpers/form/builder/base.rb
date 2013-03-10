module Caisson::Helpers::Form::Builder
  class Base
    attr_reader :interpreti, :record

    #*************************************************************************************
    # CONSTRUCTOR
    #*************************************************************************************
    def initialize(core, record)
      @core = core
      @record = record
      @interpreti = Caisson::Helpers::Form::Builder::Interpreti.new(@record)
    end


    #*************************************************************************************
    # PUBLIC INSTANCE METHODS
    #*************************************************************************************
    def line(field_name, options={})
      options.reverse_merge!(choices: nil, hint: true, id: 'undefined', label: 'undefined', nature: nil, placeholder: false, value: 'undefined')

      field = field_builder(field_name, field_options(options))

      label_str = line_label(field, force: options[:label])

      return caisson.line(label_str, field.build, line_options(field, options))
    end

    def line_label(field, options={})
      options.reverse_merge!(force: 'undefined')

      return case
        when options[:force] != 'undefined' then options[:force]
        when field.checkbox? then nil
        when field.hidden? then nil
        else field.label
      end
    end


    private

    #*************************************************************************************
    # PRIVATE INSTANCE METHODS
    #*************************************************************************************
    def field_builder(name, options={})
      Caisson::Helpers::Form::Builder::FieldBuilder::Base.new(self, name, options)
    end

    def field_options(full_options)
      options = {}
      options.reverse_merge! full_options
      options.delete :class

      return options
    end

    def line_options(field, full_options)
      options = { class: ["line-#{field.nature}", full_options[:class]].join(' ') }
      options[:class] << ' errors' if field.errors?
      options[:id] = 'line-' + full_options[:id] if not [nil, 'undefined'].include?(full_options[:id])
      options[:wrap_field] = false
      options[:placeholder] = full_options[:placeholder]
      options[:hint] = full_options[:hint]

      options[:label_separator] = '' if field.nature == 'checkbox'

      return options
    end

    def method_missing(*args, &block) return @core.send(*args, &block) end
  end
end
