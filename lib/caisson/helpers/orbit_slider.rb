module Caisson::Helpers
  class OrbitSlider
    attr_reader :core

    delegate :capture, to: :core
    delegate :content_tag, to: :core

    def initialize(core, items, options={})
      @options = build_options options

      @core = core
      @items = items
    end

    def generate(&block)
      wrap_slider build_slides(&block)
    end

    private

    def build_options(options)
      options.reverse_merge(
        advance_speed: 4000,
        animation: "horizontal-push",
        animation_speed: 400,
        bullets: false,
        bullet_thumbs: false,
        bullet_thumbs_location: '',
        caption_animation: 'fade',
        caption_animation_speed: 800,
        captions: false,
        class: 'slider',
        columns_per_slide: 1,
        directional_nav: true,
        fluid: '16x5',
        id: "slider-#{rand(10000)}",
        pause_on_hover: true,
        reset_timer_on_click: false,
        start_clock_on_mouse_out: true,
        start_clock_on_mouse_out_after: 1000,
        timer: false)
    end

    def build_item(item, last=false, &block)
      css_class = ['column']
      css_class << get_column_size
      css_class << 'end' if last

      '<li class="' + css_class.join(' ') + '">' + capture(item, &block).to_s + '</li>'
    end

    def build_slides(&block)
      slides = []

      @items.each_slice @options[:columns_per_slide] do |slice|
        content = '<div><ul class="row">'
        slice.each_with_index { |item,i| content << build_item(item, (i==slice.length-1), &block) }
        content << '</ul></div>'

        slides << content
      end

      return slides.join("\n")
    end

    def get_column_size
      case @options[:columns_per_slide]
        when 1 then 'twelve'
        when 2 then 'six'
        when 3 then 'four'
        when 4 then 'three'
        when 5,6 then 'two'
        else 'one'
      end
    end

    def parse_attribute_value(raw_value)
      case raw_value
        when true then '1'
        when false then '0'
        else raw_value
      end
    end

    def wrap_slider(content)
      attributes = { 'data-caisson' => 'orbit-slider' }

      @options.each do |k,v|
        case k.to_s
          when 'id' then attributes[:id] = v
          when 'class' then attributes[:class] = ['slider', v].compact.join(' ')
          when 'columns_per_slide' then nil
          else attributes["data-#{k}".gsub('_', '-')] = parse_attribute_value(v)
        end
      end

      return content_tag(:div, content.html_safe, attributes)
    end
  end
end
