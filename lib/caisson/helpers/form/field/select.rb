#*************************************************************************************
# Build complex graphical input field.
#*************************************************************************************
module Caisson::Helpers::Form::Field
  class Select < Caisson::Helpers::Form::Field::Base
    #*************************************************************************************
    # PUBLIC INSTANCE METHODS
    #*************************************************************************************
    def build(name, choices, selection, options={})
      options.reverse_merge!(class: nil, submit: false, translate: true)

      choices = get_choices(choices, options[:translate])

      return select_tag(name, options_for_select(choices, selection), generate_attributes(options))
    end

    private

    def generate_attributes(options)
      attributes = { class: ['select-field', options.delete(:class)].flatten.compact.join(' ') }
      attributes['data-submit'] = 1 if options[:submit]

      return attributes
    end

    def get_choices(choices, translate)
      case
        when translate then choices # TODO: Translate the fields
        when (not choices.is_a?(Array)) then choices.choices_for_select # choices are a list of records
        else choices
      end
    end
  end
end
