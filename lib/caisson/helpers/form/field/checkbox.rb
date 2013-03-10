#*************************************************************************************
# TOCOMMENT
#*************************************************************************************
module Caisson::Helpers::Form::Field
  class Checkbox < Caisson::Helpers::Form::Field::Base
    #*************************************************************************************
    # PUBLIC INSTANCE METHODS
    #*************************************************************************************
    def build(name, selected, options={})
      content = []
      content << hidden_field_tag(name, '0', id: nil)
      content << check_box_tag(name, '1', parse_selected(selected), generate_attributes(name, options))
      content << options.delete(:label)

      return content_tag(:label, content.join("\n").html_safe, :for => name.parameterize.underscore)
    end

    private

    #*************************************************************************************
    # PRIVATE INSTANCE METHODS
    #*************************************************************************************
    def generate_attributes(name, options)
      attributes = { class: ['checkbox', 'customized', options.delete(:class)].compact.join(' ') }
      attributes['title'] = options[:title] if options[:title]
      attributes['data-submit'] = 1 if options[:submit]

      return attributes
    end

    def parse_selected(selected)
      case selected
        when '0', 'false' then false
        when '1', 'true' then true
        else selected
      end
    end
  end
end
