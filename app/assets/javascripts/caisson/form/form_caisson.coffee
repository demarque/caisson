#*************************************************************************************
# TOCOMMENT
#*************************************************************************************
@caissonMod "FormCaisson", ->
  #*************************************************************************************
  # PUBLIC MODULE METHODS
  #*************************************************************************************
  @findFormById = (id) -> return form for form in @forms when form.id() is id

  @findFieldById = (id) -> return form.field(id) for form in @forms when form.hasField(id)

  @initForms = () -> $('form').each (i, form) => @forms.push new FormCaisson.Form $(form)

  @initHelpers = () ->
    $.fn.caisson = () ->
      switch $(this).data('caisson')
        when "form" then FormCaisson.findFormById $(this).attr('id')
        when "field" then FormCaisson.findFieldById $(this).attr('id')
        else FormCaisson.findFieldById $(this).closest('div[data-caisson]').attr('id') if $(this).closest('div[data-caisson]')


  @load = () ->
    @forms = []
    @initForms()
    @initHelpers()


  @reload = () -> @load()


