module Caisson::Helpers
  def caisson_header
    '<meta name="viewport" content="width=device-width, initial-scale=1.0" />'.html_safe
  end

  def grid
    @grid ||= Caisson::Helpers::Grid.new(self)
  end

  def orbit_slider(items, options={}, &block)
    Caisson::Helpers::OrbitSlider.new(self, items, options).generate(&block)
  end

  ActionView::Helpers::FormTagHelper.module_eval do
    def caisson(record=nil)
      if record
        Caisson::Helpers::Form::Builder::Base.new(self, record)
      else
        Caisson::Helpers::Form::Base.new(self)
      end
    end
  end

  ActionView::Helpers::FormBuilder.module_eval do
    def caisson
      Caisson::Helpers::Form::Builder::Base.new(@template, @object)
    end
  end

  ::ActionView::Base.send :include, self
end

require 'caisson/helpers/form'
require 'caisson/helpers/grid'
require 'caisson/helpers/orbit_slider'
