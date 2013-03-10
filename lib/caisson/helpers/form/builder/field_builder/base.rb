#*************************************************************************************
# TOCOMMENT
#*************************************************************************************
module Caisson::Helpers::Form::Builder::FieldBuilder
  class Base
    attr_reader :nature
    attr_reader :core

    delegate :content_tag, to: :core
    delegate :interpreti, to: :core

    #*************************************************************************************
    # CONSTRUCTOR
    #*************************************************************************************
    def initialize(core, name, options={})
      options.reverse_merge!(nature: nil, hint: true)

      @core = core
      @name = name
      @options = options.dup
      @record = core.record
      @show_hint = options[:hint]

      @nature = Caisson::Helpers::Form::Builder::FieldBuilder::Nature.new(@record, name).get(force: options[:nature])
    end

    #*************************************************************************************
    # PUBLIC INSTANCE METHODS
    #*************************************************************************************
    def build
      "Caisson::Helpers::Form::Builder::Field::#{@nature.camelize}".constantize.new(@core, @record, @name, @options).build
    end

    def checkbox?
      nature == 'checkbox'
    end

    def errors?
      not errors.empty?
    end

    def errors
      interpreti.field_errors(@name)
    end

    def hidden?
      @nature == 'hidden'
    end

    def hint?
      not interpreti.field_hint(@name).blank? and @show_hint
    end

    def label
      interpreti.field_label(@name)
    end

    def wrap_field(field_tags)
      css_class = ['field']
      css_class << 'errors' if errors?

      content_tag(:div, field_tags + wrapper_hint + wrapper_errors, class: css_class.join(' '))
    end

    def wrapper_errors
      if errors?
        content_tag(:div, errors.map{|e| content_tag(:span, e)}.join.html_safe, class: 'error-messages')
      else
        ''
      end
    end

    def wrapper_hint
      if hint?
        content_tag(:div, interpreti.field_hint(@name).html_safe, class: 'hint')
      else
        ''
      end
    end
  end
end
