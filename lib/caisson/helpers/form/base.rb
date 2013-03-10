#*************************************************************************************
# TOCOMMENT
#*************************************************************************************
module Caisson::Helpers::Form
  class Base
    #*************************************************************************************
    # CONSTRUCTOR
    #*************************************************************************************
    def initialize(core)
      @core = core
    end


    #*************************************************************************************
    # PUBLIC INSTANCE METHODS
    #*************************************************************************************
    def button(text, options={})
      Caisson::Helpers::Form::Button.new(@core).build(text, options)
    end

    def button_to(text, options={}, html_options={})
      Caisson::Helpers::Form::Button.new(@core).build_button_to(text, options, html_options)
    end

    def buttons(&block)
      content = '<div class="buttons row"><div class="large-12 columns">'
      content << @core.capture(self, &block)
      content << '</div></div>'

      return content.html_safe
    end

    def label(text, options={})
      options.reverse_merge!(content: '', placeholder: nil, separator: ' : ')

      label_for = options[:content].scan(/<[input|textarea|select|span|div].+id="(.+?)"./).flatten.first

      attributes = {}
      attributes[:for] = label_for if label_for
      attributes[:class] = 'placeholder' if options[:placeholder]

      text = '&nbsp;'.html_safe if text.empty?
      text += options[:separator].to_s if not options[:placeholder]

      return content_tag(:label, text, attributes)
    end

    def line(label_str, content, options={})
      options.reverse_merge!(class: nil, id: nil, label_separator: ' : ', placeholder: false)

      css_class = ['row', 'form-line', options[:class]].compact.join(' ')

      line_content = '<div class="' + css_class + '"><div class="large-12 columns field">'
      line_content << label(label_str, content: content, separator: options[:label_separator], placeholder: options[:placeholder]) if not label_str.nil?
      line_content << content
      line_content << '</div></div>'

      return line_content.html_safe
    end














    def checkbox(name, selected=false, options={})
      new_field('checkbox', name, selected, options)
    end





    def line_checkbox(label_str, field_name, selected=false, options={})
      options.reverse_merge!(label_separator: nil, wrap_field: false)

      options[:class] = [options[:class], 'line-checkbox'].compact.join(' ')

      return line(label_str, checkbox(field_name, selected), options)
    end

    def line_password(label_str, field_name, value='', options={})
      field_options = get_field_options(label_str, options)

      line(label_str, password(field_name, value, field_options), options)
    end

    def line_select(label_str, field_name, choices, selection, options={})
      line(label_str, select(field_name, choices, selection), options)
    end

    def line_static(label_str, value, options={})
      options.reverse_merge!(wrap_field: false)

      options[:class] = [options[:class], 'line-static'].compact.join(' ')

      field_options = {}
      field_options[:date_format] = options.delete(:date_format) if options[:date_format]

      line(label_str, static(value, field_options), options)
    end

    def line_switch(label_str, field_name, choices, selection, options={})
      line(label_str, switch(field_name, choices, selection), options)
    end

    def line_text(label_str, field_name, value='', options={})
      options.reverse_merge!(wrap_field: false)

      field_options = get_field_options(label_str, options)

      line(label_str, text(field_name, value, field_options), options)
    end

    def line_time(label_str, field_name, value='', options={})
      line(label_str, time(field_name, value), options)
    end

    def password(name, value='', options={})
      new_field('password', name, value, options)
    end

    def select(name, choices, selection, options={})
      options.reverse_merge!(submit: false, translate: false)

      new_field('select', name, choices, selection, options)
    end

    def static(value, options={})
      new_field('static', value, options)
    end

    def switch(name, choices, selection, options={})
      options.reverse_merge!(submit: false, translate: false)

      new_field('switch', name, choices, selection, options)
    end

    def text(name, value='', options={})
      new_field('text', name, value, options)
    end

    def time(name, value, options={})
      new_field('time_field', name, value, options)
    end

    private

    #*************************************************************************************
    # PRIVATE INSTANCE METHODS
    #*************************************************************************************
    def get_field_options(label_str, line_options)
      field_options = {}

      if line_options[:placeholder]
        field_options[:placeholder] = (line_options[:placeholder] == true) ? label_str : line_options[:placeholder]
      end

      field_options[:placeholder] = line_options[:placeholder_text] if line_options[:placeholder_text]
      field_options[:validates] = line_options.delete(:validates) if line_options[:validates]
      field_options[:maxlength] = line_options.delete(:maxlength) if line_options[:maxlength]
      field_options[:field_size] = line_options.delete(:field_size) if line_options[:field_size]

      return field_options
    end

    def line_options(options)
      options[:class] = ['line', options[:class]].compact.flatten.join(' ')
      options.delete(:label_separator)
      options.delete(:wrap_field)
      options.delete(:placeholder)
      options.delete(:placeholder_text)

      return options
    end

    def new_field(nature, *args)
      wrap_field "Caisson::Helpers::Form::Field::#{nature.camelize}".constantize.new(@core).build(*args)
    end

    def wrap_field(content)
      content_tag(:div, content, class: 'field')
    end

    def method_missing(*args, &block) return @core.send(*args, &block) end
  end
end
