module Caisson::Helpers
  def orbit_slider(items, options={}, &block)
    Caisson::Helpers::OrbitSlider.new(self, items, options).generate(&block)
  end

  ::ActionView::Base.send :include, self
end

require 'caisson/helpers/orbit_slider'
