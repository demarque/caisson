#*************************************************************************************
# Build complex graphical input field.
#*************************************************************************************
module Caisson::Helpers::Form::Field
  class Percent < Caisson::Helpers::Form::Field::Base
    #*************************************************************************************
    # PUBLIC INSTANCE METHODS
    #*************************************************************************************
    def build(name, value, options={})
      #options = parse_text_options options


      #return (text_field_tag(name, value.f_percent(symbol: false), options) + '<span class="postfix">%</span>'.html_safe).html_safe

      content = '<div class="field-percent">'
      content += text_field_tag(name, value.f_percent(symbol: false), options)
      content += content_tag(:span, '%', class: 'postfix')
      content += '</div>'

      return content.html_safe
    end
  end
end
