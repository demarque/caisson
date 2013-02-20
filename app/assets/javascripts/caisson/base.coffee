class Caisson
  constructor: () ->
    $('div[data-caisson]').each (i, component) =>
        switch $(component).data('caisson')
          when 'orbit-slider' then new OrbitSlider $(component)



$ -> new Caisson
