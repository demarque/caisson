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
      # DEPRECATED IN VERSION 4
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
      '<li>' + capture(item, &block).to_s + '</li>'
    end

    def build_slides(&block)
      slides = []

      @items.each_slice @options[:columns_per_slide] do |slice|
        content = '<li><div class="spacer"></div><ul class="wink small-block-grid-3 large-block-grid-' + @options[:columns_per_slide].to_s + '">'
        slice.each_with_index { |item,i| content << build_item(item, (i==slice.length-1), &block) }
        content << '</ul><div class="spacer"></div></li>'

        slides << content
      end

      return slides.join("\n")
    end

    def parse_attribute_value(raw_value)
      case raw_value
        when true then '1'
        when false then '0'
        else raw_value
      end
    end

    def stringify_options
      results = []

      @options.each { |k,v| results << "#{k}:#{v};" }

      return results.join
    end

    def wrap_slider(content)
      attributes = { 'data-caisson' => 'orbit-slider', 'data-orbit' => '', 'data-options' => stringify_options }

      @options.each do |k,v|
        case k.to_s
          when 'id' then attributes[:id] = v
          when 'class' then attributes[:class] = ['slider', v].compact.join(' ')
          when 'columns_per_slide' then nil
          else nil #attributes["data-#{k}".gsub('_', '-')] = parse_attribute_value(v)
        end
      end

      return content_tag(:ul, content.html_safe, attributes)
    end
  end
end
