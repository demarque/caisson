#*************************************************************************************
# Build complex graphical button.
#*************************************************************************************
module Caisson::Helpers::Form
  class Button
    #*************************************************************************************
    # CONSTRUCTOR
    #*************************************************************************************
    def initialize(core)
      @core = core
    end


    #*************************************************************************************
    # PUBLIC INSTANCE METHODS
    #*************************************************************************************
    def build(text, options={})
      options.reverse_merge!(class: '', confirm: nil, default: true, disabled: false, url: nil)

      if options[:url]
        return link(text, options.delete(:url), options)
      else
        return button(text, options)
      end
    end

    def build_button_to(text, url, options={})
      options.reverse_merge!(class: '', confirm: nil, disabled: false, method: 'get', url: nil, vars: {})

      vars = options.delete(:vars)

      return form_tag(url, method: options[:method], class: "button_to") do
        (vars.map{ |k,v| hidden_field_tag(k, v) }.join("\n") + button(text, options)).html_safe
      end
    end

    private

    #*************************************************************************************
    # PRIVATE INSTANCE METHODS
    #*************************************************************************************
    def build_options(options)
      options['data-confirm'] = options.delete(:confirm) if options[:confirm]
      options[:class] = ['button', (options[:default] ? 'default' : 'secondary'), options[:class]].compact.join(' ')
      options.delete(:method)

      return options
    end

    def button(text, options={})
      options.reverse_merge!(class: '', confirm: nil, type: 'submit')

      content_tag(:button, text, build_options(options)).html_safe
    end

    def link(text, url, options={})
      link_to(text, url, build_options(options)).html_safe
    end

    def method_missing(*args, &block) return @core.send(*args, &block) end
  end
end
