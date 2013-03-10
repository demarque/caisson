module Caisson::Helpers::Form::Builder
  class Interpreti

    def initialize(record)
      @record = record
    end

    def field_choices(name, options={})
      options.reverse_merge!(base_choices: nil, include_blank: false)

      if options[:base_choices] and options[:base_choices][0].is_a? Array
        choices = options[:base_choices]
      elsif options[:base_choices] or model_obj.respond_to? :options_for
        base_choices = [options[:base_choices] || model_obj.options_for(name.to_s)].compact.flatten
        choices = base_choices.map { |k| [field_option(name, k), k] }
      else
        choices = []
      end

      choices.insert(0, blank_choice(name)) if options[:include_blank]

      return choices
    end

    def field_errors(name)
      []
      #@core.errors[name].map{ |e| [I18n.translate_with_article('form.field'), field_label(name).downcase_utf8, e].join(' ')}
    end

    def field_hint(name)
      field_translation(name, 'hint')
    end

    def field_label(name)
      text = field_translation(name, 'label')
      text = field_translation(name) if text.empty?

      return text
    end

    def field_option(field_name, option_name, options={})
      options.reverse_merge!(text: 'label')

      text = field_translation(field_name, "options.#{option_name}.#{options[:text]}")
      text = field_translation(field_name, "options.#{option_name}") if text.empty? and options[:text] == 'label'

      return text
    end

    private

    def base_path
      "models.#{obj_name}"
    end

    def base_field_path
      "#{base_path}.fields"
    end

    def blank_choice(name)
      [I18n.translate('form.select'), '']
    end

    def field_translation(name, target=nil)
      name_path = name.to_s.include?('[') ? name.gsub('[', '.hash.').gsub(']', '') : name
      name_path = "#{name_path}.#{target}" if target

      text = I18n.translate("#{base_field_path}.#{name_path}", default: '')
      text = I18n.translate("#{parent_field_path}.#{name_path}", default: '') if translation_missing? text

      return text
    end

    def has_parent?
      false
      #parent_object ? true : false
    end

    def model_obj
      @record.class
    end

    def obj_name(class_obj=nil)
      (class_obj ? class_obj : model_obj).to_s.pluralize.underscore
    end

    def parent_object
      # TOFIX: This should be understood and fix.
      position = @core.ancestors[1].to_s.include?('#<Module') ? 2 : 1
      obj = @core.ancestors[position]

      return ((not obj or obj.to_s.include?('Mongoid')) ? nil : obj)
    end

    def parent_path
      "models." + (has_parent? ? obj_name(parent_object) : 'parent_undefined')
    end

    def parent_field_path
      "#{parent_path}.fields"
    end

    def translation_missing?(text)
      text.blank? or text.include? 'translation missing'
    end
  end
end
