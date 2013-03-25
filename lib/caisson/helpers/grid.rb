module Caisson::Helpers
  class Grid
    attr_reader :core

    delegate :capture, to: :core
    delegate :content_tag, to: :core

    def initialize(core)
      @core = core
    end

    def column(span, options={}, &block)
      options.reverse_merge! class: nil, id: nil, small: nil, tag: :div

      css_class = ['columns']
      css_class << "large-#{span}"
      css_class << "small-#{options[:small]}" if options[:small]
      css_class << options[:class] if options[:class]

      content_tag(options[:tag], capture(&block), class: css_class.join(' '), id: options[:id])
    end

    def row(options={}, &block)
      options.reverse_merge! class: nil, id: nil, tag: :div

      css_class = ['row']
      css_class << options[:class] if options[:class]

      content_tag(options[:tag], capture(&block), class: css_class.join(' '), id: options[:id])
    end
  end
end
