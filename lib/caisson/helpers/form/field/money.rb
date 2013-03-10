#*************************************************************************************
# Build complex graphical input field.
#*************************************************************************************
module FormCandy::Field
  class Money < FormCandy::Field::Base
    #*************************************************************************************
    # PUBLIC INSTANCE METHODS
    #*************************************************************************************
    def build(name, value, options={})
      options = parse_text_options options

      decimal = options[:decimal] ? options.delete(:decimal).to_i : 2
      options[:class].gsub!('text-field', 'money-field')

      options["data-validations"] = [options["data-validations"], 'numeric'].compact.join(' ')
      options["data-decimal"] = decimal

      content = text_field_tag('formatted-' + name, format_value(value, decimal), options)
      content += content_tag(:span, '$', class: 'symbol currency')
      content += hidden_field_tag(name, value, id: nil, class: 'dbdata')

      return content.html_safe
    end

    def format_value(value, decimal)
      value.blank? ? '' : sprintf("%0.0#{decimal}f", (value.to_f / (10 ** decimal)).round(decimal)).gsub('.', ',')
    end
  end
end
